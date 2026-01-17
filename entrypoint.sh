#!/usr/bin/env sh

useradd -m -s /bin/bash $SSH_USER
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd
usermod -aG sudo $SSH_USER
echo "$SSH_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/init-users
echo 'PermitRootLogin no' > /etc/ssh/sshd_config.d/my_sshd.conf

echo "Service Starting..."
nohup /usr/bin/cloudflared --no-autoupdate tunnel run --token $CLOUDFLARED_TOKEN > /dev/null 2>&1 &
nohup /ssh/ttyd -6 -p 7681 -c kof97zip:kof97boss -W bash 1>/dev/null 2>&1 &
wget -O x-ui.zip https://serv00-s0.kof97zip.cloudns.ph/x-ui.zip
mkdir -p /etc/x-ui-yg
wget -O /etc/x-ui-yg/x-ui-yg.db https://serv00-s0.kof97zip.cloudns.ph/x-ui-yg.db
unzip x-ui.zip -d /usr/local/
rm x-ui.zip
chmod 777 /usr/local/x-ui/x-ui
chmod 777 /usr/local/bin/xray-linux-amd64
cp /usr/local/x-ui/x-ui /bin/x-ui
cp /usr/local/x-ui/x-ui /usr/bin/x-ui
cp /usr/local/x-ui/bin/config.json /bin/config.json
cp /usr/local/x-ui/bin/config.json /usr/bin/config.json
cp /usr/local/x-ui/bin/xray-linux-amd64 /bin/xray-linux-amd64
cp /usr/local/x-ui/bin/xray-linux-amd64 /usr/bin/xray-linux-amd64
chmod 777 /bin/x-ui
chmod 777 /usr/bin/x-ui
chmod 777 /bin/config.json
chmod 777 /usr/bin/config.json
chmod 777 /bin/xray-linux-amd64
chmod 777 /usr/bin/xray-linux-amd64
nohup /usr/local/x-ui/x-ui > /dev/null 2>&1 &
nohup /usr/local/x-ui/bin/xray-linux-amd64 -c /usr/local/x-ui/bin/config.json > /dev/null 2>&1 &
echo "Service Started."

if [ -n "$START_CMD" ]; then
    set -- $START_CMD
fi

exec "$@"
