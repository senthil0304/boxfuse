FROM ubuntu
RUN apt-get update -y
RUN apt-get install apache2 -y
COPY hello-1.0.war /var/www/html/
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
