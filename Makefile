all:
	@sudo hostsed add 127.0.0.1 bpouchep.42.fr && echo "successfully added bpouchep.42.fr to /etc/hosts"
	@sudo mkdir -p /home/bpouchep/data/wordpress
	@sudo mkdir -p /home/bpouchep/data/mariadb
	sudo docker compose -f ./srcs/docker-compose.yml up -d

clean:
	sudo docker compose -f ./srcs/docker-compose.yml down --rmi all -v

fclean: clean
	@sudo hostsed rm 127.0.0.1 bpouchep.42.fr && echo "successfully removed bpouchep.42.fr to /etc/hosts"
	@sudo docker stop $(sudo docker ps -qa) \
   	@sudo docker rm $(sudo docker ps -qa) \
   	@sudo docker rmi -f (sudo docker images -qa) \
   	@sudo docker volume rm (sudo docker volume ls -q) \
   	@sudo docker network rm (sudo docker network ls -q) \
   	@sudo rm -rf /home/bpouchep/data/wordpress \
   	@sudo rm -rf /home/bpouchep/data/mysql \

re: fclean all

ls:
	sudo docker image ls
	sudo docker ps

.PHONY: all, clean, fclean, re, ls
