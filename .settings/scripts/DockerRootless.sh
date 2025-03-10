#!/bin/bash

# Function to check if Docker is running in rootless mode
check_rootless_docker() {
    if pgrep -f "dockerd-rootless.sh" > /dev/null; then
        echo "✔ Docker is running in rootless mode."
        return 0
    else
        echo "✖ Docker is NOT running in rootless mode."
        return 1
    fi
}

# Function to detect if the environment is WSL
check_if_wsl() {
    if grep -qEi "(microsoft|wsl)" /proc/version &> /dev/null; then
        echo "✔ This environment is WSL."
        return 0
    else
        echo "✔ This is a standard Linux distribution."
        return 1
    fi
}

# Function to start rootless Docker if it isn't running
start_rootless_docker() {
    if ! check_rootless_docker; then
        echo "Starting Docker in rootless mode..."
        nohup dockerd-rootless.sh > ~/docker-rootless.log 2>&1 &
        sleep 3  # Give the daemon some time to start
        if check_rootless_docker; then
            echo "✔ Docker rootless daemon started successfully."
        else
            echo "✖ Failed to start Docker in rootless mode. Check ~/docker-rootless.log for details."
        fi
    fi
}

# Function to ensure networking works in rootless mode
configure_rootless_networking() {
    # Check if net.ipv4.ip_unprivileged_port_start is properly set
    REQUIRED_KEY="net.ipv4.ip_unprivileged_port_start"
    REQUIRED_VALUE="80"

    CURRENT_VALUE=$(sysctl -n $REQUIRED_KEY 2>/dev/null)
    if [ "$CURRENT_VALUE" == "$REQUIRED_VALUE" ]; then
        echo "✔ $REQUIRED_KEY is already set to $REQUIRED_VALUE."
    else
        echo "✖ $REQUIRED_KEY is not set to $REQUIRED_VALUE. Updating sysctl configuration..."
        echo "$REQUIRED_KEY=$REQUIRED_VALUE" | sudo tee -a /etc/sysctl.conf > /dev/null
        sudo sysctl -p
        sysctl $REQUIRED_KEY
    fi
}

# Main execution flow
echo "Checking Docker setup..."

# Determine if the environment is WSL or Linux
if check_if_wsl; then
    echo "✔ WSL detected. Adjusting for WSL-specific configuration..."
    # If WSL, ensure /etc/resolv.conf or other networking tweaks are applied if needed
    if [ -f /etc/resolv.conf ]; then
        echo "✔ WSL DNS appears configured. Double-check Docker container network if needed."
    else
        echo "✖ WSL DNS is misconfigured. Check /etc/resolv.conf."
    fi
else
    echo "✔ Standard Linux detected. Proceeding with standard configuration."
fi

# Check if Docker is running in rootless mode
start_rootless_docker

# Configure networking for rootless mode
configure_rootless_networking

echo "Docker setup complete. Verify connectivity by running 'docker info' or starting your containers."
