FROM nginx:stable

MAINTAINER Wagner Hitomi (hyoshi84@gmail.com)

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y certbot -t jessie-backports \
    && apt-get install -y python-certbot-nginx \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

