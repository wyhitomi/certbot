FROM nginx:stable

MAINTAINER Wagner Hitomi (hyoshi84@gmail.com)

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" | tee -a /etc/apt/sources.list.d/backports.list \
      && apt-get update \
      && apt-get install -y certbot -t jessie-backports \
      && rm -rf /var/lib/apt/lists/* \
      && rm -rf /etc/apt/sources.list.d

ADD scripts/certbot.sh /usr/bin/certbot.sh

VOLUME /var/www

RUN chmod +x /usr/bin/certbot.sh

ADD domains/* /domains/
