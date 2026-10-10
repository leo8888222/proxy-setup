#!/bin/bash
set -e
echo "=== 安装 Shadowsocks + V2Ray ==="
apt-get update -qq
apt-get install -y -qq shadowsocks-libev qrencode curl > /dev/null 2>&1

# 生成随机密码和端口
SS_PASS=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 16)
SS_PORT=$(shuf -i 10000-60000 -n 1)

# 写配置
mkdir -p /etc/shadowsocks-libev
cat > /etc/shadowsocks-libev/config.json << EOC
{
    "server": "0.0.0.0",
    "server_port": $SS_PORT,
    "password": "$SS_PASS",
    "method": "aes-256-gcm",
    "timeout": 300,
    "fast_open": true
}
EOC

systemctl enable shadowsocks-libev > /dev/null 2>&1 || true
systemctl restart shadowsocks-libev || service shadowsocks-libev restart || ss-server -c /etc/shadowsocks-libev/config.json -d start

IP=$(curl -s ifconfig.me || curl -s ipinfo.io/ip)

echo ""
echo "=========================================="
echo " 搭建完成！"
echo "=========================================="
echo "服务器 IP: $IP"
echo "端口: $SS_PORT"
echo "密码: $SS_PASS"
echo "加密: aes-256-gcm"
echo ""
echo "SS 链接:"
SS_LINK=$(echo -n "aes-256-gcm:$SS_PASS@$IP:$SS_PORT" | base64 -w 0)
echo "ss://$SS_LINK"
echo "=========================================="
