FROM php:7.2-apache
COPY ./ /var/www/html

ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN chown -R www-data:www-data /var/www

EXPOSE 80
