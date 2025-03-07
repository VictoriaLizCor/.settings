When running Docker in rootless mode, non‑root processes are restricted from binding to ports below 1024 (so-called “privileged” ports). That’s why when you try to expose port 80, you get the error. Fortunately, you have three ways to address this:

---

### **Method 1: Use a Non‑Privileged Port**

**Quickest fix:** Change your container’s port mapping to a port number ≥1024.

For example, instead of mapping port 80, you could use 8080:

- **Docker Compose Example:**  
  Change from:
  ```yaml
  ports:
    - "80:80"
  ```
  To:
  ```yaml
  ports:
    - "8080:80"
  ```
- **Direct Docker Run Example:**  
  Change from:
  ```bash
  docker run -p 80:80 your-image
  ```
  To:
  ```bash
  docker run -p 8080:80 your-image
  ```

This avoids the privileged port issue altogether.

---

### **Method 2: Lower the Unprivileged Port Threshold**

You can adjust the kernel parameter so that non‑root users are allowed to bind to ports as low as 80.

1. **Edit the sysctl Configuration**

   Open `/etc/sysctl.conf` with your favorite editor in WSL:
   ```bash
   sudo nano /etc/sysctl.conf
   ```

2. **Add the Following Line**
   ```ini
   net.ipv4.ip_unprivileged_port_start = 80
   ```
   This change tells the kernel to allow non‑root processes to bind to any port ≥80 (instead of the default 1024).

3. **Reload the Sysctl Settings**
   ```bash
   sudo sysctl --system
   ```
   Verify the change:
   ```bash
   sysctl net.ipv4.ip_unprivileged_port_start
   # It should now report 80
   ```

With this in place, your rootless Docker daemon should be able to bind to port 80.

---

### **Method 3: Grant CAP_NET_BIND_SERVICE to RootlessKit**

You can give the binary responsible for managing port bindings (typically part of RootlessKit) the capability to bind privileged ports.

1. **Locate the RootlessKit Binary**

   Often it's in your PATH; verify by running:
   ```bash
   which rootlesskit
   ```

2. **Set the Capability**
   ```bash
   sudo setcap cap_net_bind_service=+ep $(which rootlesskit)
   ```
   This command grants `rootlesskit` the `CAP_NET_BIND_SERVICE` capability, allowing it to bind to ports below 1024.

---

### **Which Method to Choose?**

- **For ease and safety:**  
  Use **Method 1** and simply map to a port ≥1024.

- **If you need to expose port 80:**  
  **Method 2** (adjusting the kernel parameter) is often the most straightforward in a controlled environment like WSL.

- **Or if you prefer not to change global kernel parameters:**  
  **Method 3** can be used, though it’s slightly more involved.

Each approach has trade-offs regarding security and convenience.

---
