Since you don't have sudo or admin privileges, you won't be able to modify system-wide configuration files like /etc/resolv.conf directly. However, you can still set up a user-specific dnsmasq configuration. Here's how:

    Create a user-specific dnsmasq configuration: Create a directory for your user-specific systemd services if it doesn't exist:

    mkdir -p ~/.config/systemd/user

    Create a dnsmasq service file: Create a service file for dnsmasq in the user-specific systemd directory:

    nano ~/.config/systemd/user/dnsmasq.service

    Add the following content to the file:

    [Unit]
    Description=DNS caching server.
    After=network.target

    [Service]
    ExecStart=/usr/sbin/dnsmasq --no-daemon --conf-file=%h/.dnsmasq.conf
    Restart=on-failure

    [Install]
    WantedBy=default.target

    Create a dnsmasq configuration file: Create a dnsmasq configuration file in your home directory:

    nano ~/.dnsmasq.conf

    Add the following lines, replacing 10.13.1.1 with your static IP address:

    interface=enp6s0
    listen-address=10.13.1.1
    bind-interfaces
#address=lilizarr.42.fr:443:10.13.1.1 
    Enable and start the user-specific dnsmasq service: Enable the service to start on login:

    systemctl --user enable dnsmasq

    Start the service:

    systemctl --user start dnsmasq

    Set up a user-specific DNS resolver: Since you can't modify /etc/resolv.conf, you can create a user-specific resolver configuration. Create a script to update the DNS settings for your user session:

    nano ~/.set_dns.sh

    Add the following content:

    #!/bin/bash
    echo "nameserver $(hostname -i)" > ~/resolv.conf
    export RES_OPTIONS="ndots:0"
    export RESOLV_CONF=~/resolv.conf

    Make the script executable:

    chmod +x ~/.set_dns.sh

    Run the script: Execute the script to apply the DNS settings:

    source ~/.set_dns.sh

These steps should help you set up dnsmasq with the static IP address of your enp6s0 interface without needing sudo or admin privileges. If you encounter any issues, feel free to ask!


Since you do not have `sudo` privileges and cannot modify the system-wide `apt` configuration, you can manually download and build the `socat` source code from its official repository. Here are the steps to do this:

1. **Download the `socat` Source Code:**
   Download the `socat` source code from its official repository.

   ```sh
   wget http://www.dest-unreach.org/socat/download/socat-1.7.4.3.tar.gz
   tar -xzf socat-1.7.4.3.tar.gz
   cd socat-1.7.4.3
   ```

2. **Build and Install Locally:**
   Configure, build, and install `socat` locally in your home directory.

   ```sh
   ./configure --prefix=$HOME
   make
   make install
   ```

3. **Verify Installation:**
   Verify that `socat` is installed correctly by checking its version.

   ```sh
   $HOME/bin/socat -V
   ```

By following these steps, you should be able to download, build, and install `socat` locally without requiring `sudo` privileges.