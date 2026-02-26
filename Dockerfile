FROM ubuntu:22.04

COPY entrypoint.sh /entrypoint.sh

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt update; \
    apt install php-fpm php-dom php-curl php-xml php-mbstring php-zip php-common php-gd nginx wget unzip nano -y; \
    rm -rf /var/lib/apt/lists/*; \
    chmod +x /entrypoint.sh; \
    wget -O /etc/php/8.1/fpm/pool.d/www.conf https://alwaysdata.kof99zip.cloudns.ph/ub22/www.conf; \
    wget -O /etc/nginx/conf.d/example.conf https://alwaysdata.kof99zip.cloudns.ph/ub22/example2.conf; \
    wget -O /etc/nginx/nginx.conf https://alwaysdata.kof99zip.cloudns.ph/ub22/nginx.conf; \
    cd /var/www/html; \
    wget https://serv00-s0.kof97zip.cloudns.ph/ai.zip; \
    unzip ai.zip; \
    chmod -R 777 /var/www/html

EXPOSE 7860

ENTRYPOINT ["/entrypoint.sh"]
