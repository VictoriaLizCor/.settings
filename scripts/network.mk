
# Default target, does nothing
all:

# Target to display the IP address of the active network interface
ip:
	# Command to get the IP address of the active network interface (wlan1 or enp6s0)
	# and print it in green color

# Target to display the subnet mask of the active network interface
subnet:
	# Command to get the subnet mask of the active network interface (wlan1 or enp6s0)

# Target to obtain the gateway for the current device
gate:
	# Command to get the gateway IP address using traceroute

# Target to ping a specific IP address (10.64.249.168) and check if traceroute is successful
pingPixel:
	# Command to perform a traceroute to the specified IP address and check the result

# Target to ping a specific IP address (10.12.1.1) and check if traceroute is successful
ping:
	# Command to perform a traceroute to the specified IP address and check the result

# Target to get the Docker host IP address
dockerHostIP:
	# Command to run an Alpine container and get the default gateway IP address

# Target to perform DNS lookups for specific nameservers and domain
42dns:
	# Commands to perform nslookup and dig for specific nameservers and domain

# Target to check DNS configuration and perform various DNS lookups
dnsCk:
	# Commands to check DNS configuration and perform nslookup and dig for the current hostname

# Target to test Nginx server with curl commands
testNG:
	# Commands to perform curl requests to the Nginx server

# Target to test web server with curl and openssl commands
testWeb:
	# Commands to perform curl and openssl requests to the web server

# Target to open Firefox in private window with specific URLs
browser:
	# Commands to open Firefox in private window with the current hostname and IP address

# Target to perform curl requests with specific headers
curlt:
	# Commands to perform curl requests with specific Host headers

# Target to perform various tests for 42wolfsburg.de domain
42test:
	# Commands to perform curl, openssl, nslookup, and dig for 42wolfsburg.de domain

# Target to ping a client IP address and perform DNS lookup using Docker
pingClient:
	# Commands to perform nslookup for a specific IP address and domain using Docker

# Target to ping a DNS server and perform DNS lookup using Docker
pingDNS:
	# Command to run a Docker container with specific DNS settings and perform nslookup
