#!bin/sh
openrc # Es el sistma de servicios de Alpine. Te permite poder ejecuta el comando service en este sistema operativo
touch /run/openrc/softlevel

service nginx start # Arranca el servidor
tail -f /dev/null # Mantiene el contenedor en run si que se apague
