#!/bin/bash

## este script sincroniza Centos con la hora de Windows

# install chrony
echo "Instalando chrony.."
yum udpdate && yum install chrony -y 

# start and enabled service

systemctl start chronyd
systemctl enable chronyd

# Add time server (Microsoft)

echo "time.windows.com" > /etc/chrony.conf

# restart chrony

systemctl restart chronyd

echo "Mostrando fecha $(date)"

