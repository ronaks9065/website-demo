FROM httpd:2.4.51
COPY . /usr/local/apache2/htdocs/
EXPOSE 80
