# Use the official PHP image as the base image
FROM php:7.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev

# Clear the apt-get caches
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd pdo pdo_mysql zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy the Laravel application into the container
COPY . .

# Install application dependencies
RUN composer install

# Generate Laravel application key
RUN php artisan key:generate

# Expose port 9000 (adjust if necessary)
EXPOSE 9000

# Start the PHP-FPM server
CMD ["php-fpm"]
