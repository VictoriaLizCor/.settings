all:

ip:
	ifconfig `ifconfig wlan1 >/dev/null 2>&1 && echo wlan1 || echo enp6s0` |  grep 'inet ' | awk '{print $$2}'

# obtain gateway for current device
gate:
	@traceroute -m 1 8.8.8.8 | awk 'NR==2 {print $$3}' | tr -d '()'


pingPixel:
	@ip="10.64.249.168"; \
	traceroute -m 3 -q 1 $$ip >/dev/null 2>&1; \
	if [ $$? -eq 0 ]; then \
		echo "Traceroute to $$ip was successful"; \
	else \
		echo "Traceroute to $$ip failed"; \
	fi

ping:
	@ip="10.12.1.1"; \
	traceroute -m 3 -q 1 $$ip >/dev/null 2>&1; \
	if [ $$? -eq 0 ]; then \
		echo "Traceroute to $$ip was successful"; \
	else \
		echo "Traceroute to $$ip failed"; \
	fi

dnsCk:
	-nslookup lilizarr.pong.42.fr
	-dig lilizarr.pong.42.fr

testNG:
	-docker exec -it nginx curl -I http://lilizarr.pong.42.fr
	@echo ----
	-docker exec -it nginx curl -k https://lilizarr.pong.42.fr
	@echo;echo "----" ;
	-docker exec -it nginx openssl s_client -connect https://lilizarr.pong.42.fr

testWeb:
	-curl -I http://lilizarr.pong.42.fr
	@echo ----
	-curl -k https://lilizarr.pong.42.fr
	@echo ----
	-curl -k https://lilizarr.pong.42.fr
	@echo;echo "----" ;
	-openssl s_client -connect lilizarr.pong.42.fr:443
#	@docker exec -it nginx openssl s_client -connect lilizarr.pong.42.fr:443