# Base image for NGINX
FROM alpine:3.13
# Sets a specific path for the prompt
RUN apk update
# Instala el paquete nginx
RUN apk add nginx
# Instala Secure SHell - una forma conveniente de usar un shell en otro sistema de forma segura. Se utiliza habitualmente en Linux
RUN apk add openssh
# Instala el paquete para generar certificados ssl
RUN apk add openssl
# Instala openrc. OpenRC es el sistema init utilizado en alpine. El sistema init gestiona los servicios, el arranque y el apagado del ordenador.
RUN apk add openrc
# Muevo el archivo de configuracion de nginx que he creado y que se encuentra en srcs a la ruta dentro del contenedor
COPY ./srcs/nginx.conf /etc/nginx/nginx.conf
# He personalizado un index.html que sustituye al que aparece por defecto. Lo muevo de srcs a la ruta del contenedor que le corresponde
COPY ./srcs/index.html /var/www/html/
# Copia el script de arranque de srcs y lo mete en la carpeta de archivos temporales del contenedor
COPY ./srcs/start.sh /tmp
# Abre permisos de ejecucion para el script que se ejecuta mas abajo
RUN chmod +x /tmp/start.sh
# Genera un certificado de 365 dias utilizando el metodo de encriptacion rsa:2048 y los certificados los guardad en la carpeta /etc/ssl/private/localhost.key
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt >/dev/null

# Entra dentro del contenedor y ejecuta el script que hemos dejado antes en la ruta /tmp/ para arrancar los servicios
CMD sh ./tmp/start.sh
