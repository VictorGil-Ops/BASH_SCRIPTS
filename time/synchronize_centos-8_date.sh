#!/bin/bash

## este script sincroniza Centos con la hora de Windows
## es posible cambiar el pool ntp https://www.pool.ntp.org/zone/es

# install chrony
echo "Instalando chrony.."
yum update && yum install chrony -y 

# start and enabled service

systemctl start chronyd
systemctl enable chronyd

# Add time server (Microsoft)

echo "server time.windows.com" >> /etc/chrony.conf

# restart chrony

systemctl restart chronyd

echo "Mostrando fecha $(date)"