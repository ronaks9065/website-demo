FROM httpd:2.4.51-alpine
COPY . /usr/local/apache2/htdocs/
EXPOSE 80
