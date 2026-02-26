FROM ubuntu:22.04

ENV TZ=Asia/Shanghai \
    SSH_USER=ubuntu \
    SSH_PASSWORD=kof97boss \
    START_CMD=''

COPY entrypoint.sh /entrypoint.sh
COPY reboot.sh /usr/local/sbin/reboot

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt update; \
    apt install php-fpm php-dom php-curl php-xml php-mbstring php-zip php-common php-gd nginx wget unzip nano -y; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir /var/run/sshd; \
    chmod +x /entrypoint.sh; \
    chmod +x /usr/local/sbin/reboot; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone; \
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
CMD ["/usr/sbin/sshd", "-D"]
