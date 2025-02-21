# Use an official PHP image as the base image
FROM php:8.1-apache

# Set the working directory inside the container
WORKDIR /var/www/html

# Install required PHP extensions and dependencies
RUN apt-get update && apt-get install -y \
       libpng-dev \
       libjpeg-dev \
       libfreetype6-dev \
       libzip-dev \
       zip \
       unzip \
       libxml2-dev \
       libicu-dev \
       libexif-dev 

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
       && docker-php-ext-install gd pdo pdo_mysql zip mysqli intl exif

# Enable Apache2 modules
RUN a2enmod rewrite

# Copy the Laravel application files to the container
COPY . .

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install application dependencies using Composer
RUN composer update

# Expose port 9000 for PHP-FPM
EXPOSE 80

# Entry point command to start Apache2
CMD ["apache2-foreground"]

