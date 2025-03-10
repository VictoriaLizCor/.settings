Below is a complete, step‐by‐step guide to setting up and running Docker in rootless mode inside WSL. This walkthrough assumes you’re working in a WSL2 Ubuntu (or Debian‑based) environment and that you have a recent Docker version (20.10 or later).

> **Note:** In rootless mode non‑root processes cannot bind to ports below 1024 (privileged ports). If you need to expose port 80 or any port <1024 later, refer to the “privileged ports” section at the end.

---

## 1. Confirm Your Environment

1. **Verify you’re on WSL2:**  
   Open a terminal and run:
   ```bash
   uname -a
   ```
   Look for “WSL” or “microsoft-standard-WSL2” in the output.

2. **Update Your Packages:**
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

---

## 2. Install Required Packages

Rootless Docker needs additional packages for user namespaces and networking:

1. **Install uidmap (which provides newuidmap and newgidmap), along with networking utilities:**
   ```bash
   sudo apt install -y uidmap slirp4netns fuse-overlayfs
   ```

   - **`uidmap`** is necessary for user namespace mapping.
   - **`slirp4netns`** and **`fuse-overlayfs`** help with networking and filesystem overlay features in rootless mode.

---

## 3. Configure UID/GID Mappings

Rootless mode requires that your user has an allocated range of subordinate UIDs and GIDs.

1. **Edit `/etc/subuid`:**
   ```bash
   sudo nano /etc/subuid
   ```
   Add the following line—replace `your_username` (or use your actual username, e.g., `victoria-lilizarr`):
   ```
   your_username:100000:65536
   ```

2. **Edit `/etc/subgid`:**
   ```bash
   sudo nano /etc/subgid
   ```
   Add the same line:
   ```
   your_username:100000:65536
   ```

Save and exit your editor.

---

## 4. Install and Configure Docker Rootless Mode

Docker now includes a tool called `dockerd-rootless-setuptool.sh` to set up rootless mode.

1. **Run the Rootless Installation Script:**
   
   In your terminal, execute:
   ```bash
   dockerd-rootless-setuptool.sh install
   ```
   This script will:
   - Set up configuration files in your home directory.
   - Create a dedicated Docker CLI context named “rootless.”
   - Provide recommendations for updating your environment.

   If you get a “command not found” error, check that your Docker installation includes the rootless extras (sometimes available via the package `docker-ce-rootless-extras`).

2. **Follow Post‑Install Instructions:**  
   The tool may advise that you add your personal bin directory to your PATH. For example, if it recommends that you add `/home/your_username/bin`:
   ```bash
   echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
   ```

---

## 5. Set Environment Variables

There are two approaches for telling your Docker client how to reach the daemon:
- **Using a CLI Context:**  
  The rootless setup creates a context named “rootless.” You can select it by running:
  ```bash
  docker context use rootless
  ```
  **Important:** If an environment variable `DOCKER_HOST` is set, it overrides the context. In that case, you can either unset it or remove it from your startup files.

- **Using DOCKER_HOST Directly:**  
  Many guides for WSL’s rootless mode recommend setting:
  ```bash
  export DOCKER_HOST=unix:///mnt/wslg/runtime-dir/docker.sock
  ```
  However, a more common approach (and the one used in many official docs) is to point DOCKER_HOST to your runtime directory. For example:
  ```bash
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"
  ```
  *Decide on one approach. If you want to rely on the “rootless” CLI context you may choose to unset DOCKER_HOST:*
  ```bash
  unset DOCKER_HOST
  ```
  
**To make these changes permanent, add your chosen lines to your `~/.bashrc`.** For example, if you want to set PATH and use the runtime directory:
```bash
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
echo 'export XDG_RUNTIME_DIR="/run/user/$(id -u)"' >> ~/.bashrc
echo 'export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"' >> ~/.bashrc
```
> *Tip:* If you prefer to use the Docker CLI context named “rootless” (which the setup script creates), ensure that `DOCKER_HOST` is not forcing a different socket. You can comment out any DOCKER_HOST lines while testing.

Reload your shell:
```bash
source ~/.bashrc
```

---

## 6. Start the Rootless Docker Daemon

Because WSL lacks systemd, you must start the daemon manually.

### **A. Manual Startup**

Run:
```bash
dockerd-rootless.sh > ~/docker-rootless.log 2>&1 &
```
This starts the rootless Docker daemon in the background and logs output to `~/docker-rootless.log`. Wait a few seconds for it to initialize, then run:
```bash
docker info
```
to verify that the daemon is running.

### **B. Automate Startup via .bashrc**

To have the daemon start automatically when you open a terminal in WSL, add this snippet to your `~/.bashrc`:
```bash
# Auto-start Docker daemon in rootless mode when running under WSL
if grep -qi 'microsoft' /proc/version; then
    export PATH=$HOME/bin:$PATH
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
    export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"
    
    # If you want to use the rootless CLI context, consider unsetting DOCKER_HOST:
    # unset DOCKER_HOST
    
    # Check if the rootless Docker daemon is running, and start if not.
    if ! pgrep -f "dockerd-rootless.sh" > /dev/null; then
        echo "Starting Docker daemon in rootless mode..."
        nohup dockerd-rootless.sh > ~/docker-rootless.log 2>&1 &
        sleep 3  # Give it a moment to initialize.
    fi
fi
```
Save and reload with:
```bash
source ~/.bashrc
```

---

## 7. Verify Your Setup

Now test your installation:
```bash
docker info
```
You should see output that shows the Docker daemon’s configuration and that it’s running in rootless mode (check for the appropriate socket path).

You can also list containers or try a simple container run:
```bash
docker run hello-world
```

---

## 8. Privileged Ports and Further Considerations

Because rootless mode restricts binding to ports below 1024, if you try to map a container’s port 80 to your host’s port 80, you might get a permission error. To work around this, you have three options:

### **A. Use a Non‑Privileged Port**
Change your mapping from port 80 to a port above 1024 (e.g., 8080):
```yaml
ports:
  - "8080:80"
```

### **B. Lower the Unprivileged Port Threshold**
Edit `/etc/sysctl.conf` (this requires sudo and affects your kernel settings):
```bash
sudo nano /etc/sysctl.conf
```
Add:
```ini
net.ipv4.ip_unprivileged_port_start=80
```
Then apply with:
```bash
sudo sysctl --system
```

### **C. Grant RootlessKit the Necessary Capability**
If available, grant `CAP_NET_BIND_SERVICE` to the rootlesskit binary:
```bash
sudo setcap cap_net_bind_service=+ep $(which rootlesskit)
```

---

By following these steps, you will have a working Docker installation running in rootless mode inside WSL without needing `sudo` for Docker commands. This setup improves security by avoiding root privileges while still allowing you to run containers.

If you have any further questions or run into issues along the way, feel free to ask!