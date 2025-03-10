If you want to test your Docker‑hosted webserver running in WSL from your cellphone (on the same local network), you need to make sure that the service port is accessible outside of WSL. Here’s how you can achieve that:

---

## 1. Expose the Container Port on the Host

When you run your Docker container inside WSL, use the `-p` flag to publish the container’s port to the host. For example, if your webserver listens on port 3000, run:

```bash
docker run -p 3000:3000 your-image
```

This makes the container’s port 3000 available on the WSL host (and possibly, through Docker Desktop integration, on the Windows host).

---

## 2. Verify Access from Windows

- **If You’re Using Docker Desktop with WSL Integration:**  
  Typically, Docker Desktop maps container ports to `localhost` on your Windows host. Open a browser on your Windows computer and visit:

  ```
  http://localhost:3000
  ```

  If that works, then the container is correctly exposed.

- **Otherwise:**  
  Check that the container is reachable inside WSL by running:

  ```bash
  curl http://localhost:3000
  ```
  
  on your WSL terminal.

---

## 3. Make the Service Accessible to Other Devices on Your Network

Your cellphone won’t be able to use `localhost` from your Windows/WSL machine. You’ll need to use the Windows host’s local network IP address.

### A. Determine Your Windows Host’s Local IP

1. Open a Command Prompt or PowerShell on your Windows host.
2. Run the following command:

   ```cmd
   ipconfig
   ```

3. Look for the IPv4 address under your active network adapter (typically something like `192.168.1.xxx`).

### B. Test Access from Windows Using This IP

On your Windows machine, open a browser and type:

```
http://<WINDOWS_IP_ADDRESS>:3000
```

Replace `<WINDOWS_IP_ADDRESS>` with the IPv4 address you found. If everything is working, you should see your webserver’s response.

---

## 4. Configure Port Forwarding if Needed

Depending on how your network is set up (and whether you’re using Docker Desktop or running Docker directly in WSL), you may need to manually set up port forwarding from your Windows host to the WSL network.

### Using Windows Port Proxy (netsh)

1. Open an **elevated** Command Prompt or PowerShell (run as Administrator).
2. If your Docker container is running in WSL and you know your current WSL IP (from running `hostname -I` in WSL), forward the port using:

   ```cmd
   netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=3000 connectaddress=<WSL_IP> connectport=3000
   ```

   Replace `<WSL_IP>` with your WSL instance’s IP address (e.g., the output of `hostname -I` in WSL).

3. This command tells Windows to listen on all network interfaces (`0.0.0.0`) for port 3000 and forward any incoming traffic to port 3000 on your WSL's IP.

*Keep in mind:*
- The WSL IP may change when you restart WSL, so you might need to update the port proxy.
- Make sure the Windows Firewall permits inbound traffic on the chosen port.

---

## 5. Access the Service from Your Cellphone

Once the above steps are complete, on your cellphone (both connected to the same Wi‑Fi network):

1. Open a browser.
2. Enter the address:

   ```
   http://<WINDOWS_IP_ADDRESS>:3000
   ```

   Replace `<WINDOWS_IP_ADDRESS>` with your Windows machine’s local IP (e.g., `192.168.1.100`).

If everything is set up correctly, you should see your webserver running in the Docker container.

---

## Summary

- **Expose the port:** Use the `-p` flag in Docker to forward the container’s port.
- **Determine the host IP:** Get your Windows machine’s IP using `ipconfig`.
- **Test locally:** Verify that your service is accessible on Windows using the IP.
- **Set up port proxy if needed:** Use `netsh` to forward ports from Windows to WSL.
- **From your cellphone:** Access the service via `http://<WINDOWS_IP>:<port>`.

Following these steps will allow your cellphone to test your service running inside Docker on WSL over your local network. If you run into issues (for example, firewall rules or changing IP addresses), adjust the Windows firewall settings or update your port proxy configuration accordingly.