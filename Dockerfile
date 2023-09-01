# Use an official PHP image as the base image
FROM php:8.1-fpm

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

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the Laravel application files to the container
COPY . .

# Install application dependencies using Composer
RUN composer update

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Entry point command to start PHP-FPM
CMD ["php-fpm"]

