FROM debian:buster

			#-----APT-----
RUN apt update -y ; \
	apt upgrade -y ; \
	apt install nginx -y ; \
	apt install curl -y ; \
	apt install openssl -y

			#-----TSL-----
	#---Creation du certificat----
#   -nodes   specifie l'absence de mot de passe
#   -out    specifie ou stocker le certificat
#   -keyout  specifie ou stocker la clée
#   -subj   preremplir les informations (type organisation etc...)
 RUN 	mkdir -p /etc/nginx/ssl ; \
		openssl req -x509 \
					-nodes \
					-out /etc/nginx/ssl/inception.crt \
					-keyout /etc/nginx/ssl/inception.key \
					-subj "/c=FR/ST=IDF/L=Nice/O=42/OU=42/CN=sajansse.42.fr/UID=sajansse" 

			#-----CONFIG-----
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

			#-----NGINX-----
RUN chmod 755 /var/www/html ; \
	chown -R www-data:www-data /var/www/html
	
CMD ["nginx", "-g", "daemon off;"]