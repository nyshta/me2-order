# Development-friendly Dockerfile for a Symfony app (PHP 8.4)
# Assumptions: project root contains composer.json and Symfony app; docker-compose mounts project into /srv/app.

FROM php:8.4-fpm

# Allow build-time customization of the non-root uid/gid if you want to chown files later
ARG UID=1000
ARG GID=1000

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/composer

WORKDIR /srv/app

# Install system packages and PHP extensions required by Symfony (+ Postgres support)
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        unzip \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        libwebp-dev \
        libfreetype6-dev \
        libicu-dev \
        libpq-dev \
        libxml2-dev \
        libonig-dev \
        zip \
        curl; \
    docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp; \
    docker-php-ext-install -j"$(nproc)" \
        intl \
        pdo \
        pdo_pgsql \
        mbstring \
        xml \
        zip \
        opcache \
        gd; \
    pecl install xdebug || true; \
    docker-php-ext-enable xdebug || true; \
    rm -rf /var/lib/apt/lists/*;

# Bring Composer from the official image (fast and reliable)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Create a composer cache dir so docker layer can cache between builds if desired
RUN mkdir -p /root/.composer && chmod 0777 /root/.composer

# Expose PHP-FPM port
EXPOSE 9000

# Default workdir is the mounted project in dev; keep the default php-fpm entrypoint/cmd
CMD ["php-fpm"]
