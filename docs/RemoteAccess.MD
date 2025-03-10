# Running a Local Service Accessible Remotely

Introduction

    Objective: Run a service on a local machine and make it accessible remotely from any host.
    Key Considerations: Configuration, security, and accessibility.

Steps to Run Your Service Locally and Access Remotely

    Set Up Your Service Locally
        Ensure your service is running on your local machine.
        Verify local accessibility via localhost or 127.0.0.1.

    Configure Your Firewall
        Allow incoming connections on the port your service is running on.
        Example: Open port 8080 if your service runs on it.

    Port Forwarding
        Set up port forwarding on your router to direct traffic to your local machine.
        Access your router’s settings and configure port forwarding for the specific port.

    Dynamic DNS (Optional)
        Use a Dynamic DNS (DDNS) service if your IP address changes frequently.
        DDNS maps a domain name to your changing IP address.

    Accessing the Service Remotely
        Use your public IP address and the forwarded port to access your service.
        Example: http://203.0.113.1:8080.

Security Considerations

    Use HTTPS
        Secure your service with HTTPS to encrypt data transmission.
        Obtain a free SSL/TLS certificate from Let’s Encrypt.

    Authentication and Authorization
        Implement strong authentication and authorization mechanisms.
        Protect your service from unauthorized access.

    Regular Updates
        Keep your software and dependencies up to date.
        Protect against known vulnerabilities.

Example Configuration

    Local Service
        Service running on localhost:8080.

    Router Port Forwarding
        Forward external port 8080 to internal IP 192.168.1.100 on port 8080.

    Access Remotely
        Access the service via http://203.0.113.1:8080.

Conclusion

    Configuration: Properly set up your local service and configure your firewall and router.
    Security: Implement HTTPS, authentication, and regular updates.
    Accessibility: Use port forwarding and DDNS for remote access.

```
[lilizarr@c2r1s2:~/42_Cursus/ft_transcendence]$ traceroute 10.64.250.214
traceroute to 10.64.250.214 (10.64.250.214), 30 hops max, 60 byte packets
 1  _gateway (10.12.254.254)  0.549 ms  0.664 ms  0.858 ms
 2  10.64.250.214 (10.64.250.214)  5.999 ms  5.992 ms  5.985 ms
[lilizarr@c2r1s2:~/42_Cursus/ft_transcendence]$ tracepath 10.64.250.214
 1?: [LOCALHOST]                      pmtu 1500
 1:  _gateway                                              0.708ms 
 1:  _gateway                                              0.692ms 
 2:  10.64.250.214                                         4.661ms reached
     Resume: pmtu 1500 hops 2 back 2 


```

`find . -type d -name '*service*' -exec sh -c 'touch "$0/Dockerfile" "$0/.dockerignore"' {} \;`

`find services/* -type d -path '*/src' -prune -o -type d -print`

`find services/ -type d -name '*-service'`

` openssl s_client -connect DOMAIn:443`