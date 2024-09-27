FROM ubuntu
RUN apt-get update -y
RUN apt-get install apache2 -y
COPY /var/lib/jenkins/workspace/javaproject/target/*.war /var/www/html/
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
