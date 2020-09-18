FROM daocloud.io/php:7.2-fpm-alpine
LABEL maintainer="chazz.top"
ENV PHP_EXT_SWOOLE=swoole-4.4.18
# 修改镜像源 无法安装替换源
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
# 安装依赖,核心扩展,pecl扩展,git,npm,nodejs
    && apk update \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        imagemagick-dev \
        libtool \
        libxml2-dev \
        postgresql-dev \
        sqlite-dev \
	    libmcrypt-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
    && apk add --no-cache \
        curl \
        git \
        imagemagick \
        postgresql-libs \
        nodejs \
        nodejs-npm \
    && npm config set registry https://registry.npm.taobao.org \
    && pecl install imagick \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install \
        curl \
        mbstring \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        pdo_sqlite \
        pcntl \
        tokenizer \
        xml \
        zip \
	&& docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" gd \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && cd /tmp \
    && pecl download $PHP_EXT_SWOOLE \
    && mkdir -p /tmp/$PHP_EXT_SWOOLE \
    && tar -xf ${PHP_EXT_SWOOLE}.tgz -C /tmp/$PHP_EXT_SWOOLE --strip-components=1 \
    && docker-php-ext-configure /tmp/$PHP_EXT_SWOOLE --enable-openssl \
    && docker-php-ext-install /tmp/$PHP_EXT_SWOOLE \
    && rm -rf /tmp/${PHP_EXT_SWOOLE}* \
    && rm -rf /tmp/pear \
# 对其他容器开放9000端口
EXPOSE 9000