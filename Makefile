all:
	@sudo hostsed add 127.0.0.1 bpouchep.42.fr && echo "successfully added bpouchep.42.fr to /etc/hosts"
	sudo docker compose -f ./srcs/docker-compose.yml up -d

clean:
	sudo docker compose -f ./srcs/docker-compose.yml down --rmi all -v

fclean: clean
	@sudo hostsed rm 127.0.0.1 bpouchep.42.fr && echo "successfully removed bpouchep.42.fr to /etc/hosts"
	@if [ -d "/home/bpouchep/data/wordpress" ]; then \
	sudo rm -rf /home/bpouchep/data/wordpress/* && \
	echo "successfully removed all contents from /home/bpouchep/data/wordpress/"; \
	fi;

	@if [ -d "/home/bpouchep/data/mariadb" ]; then \
	sudo rm -rf /home/bpouchep/data/mariadb/* && \
	echo "successfully removed all contents from /home/bpouchep/data/mariadb/"; \
	fi;

re: fclean all

ls:
	sudo docker image ls
	sudo docker ps

.PHONY: all, clean, fclean, re, ls
