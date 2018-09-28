#! /bin/bash

echo "Cloud init starting at `date`" > /tmp/init.log
hostname ${hostname}
echo "127.0.0.1 ${hostname}" >> /etc/hosts

ufw allow 80
ufw allow 443

apt install apache2 -y >> /tmp/init.log
systemctl enable apache2 >> /tmp/init.log
systemctl restart apache2 >> /tmp/init.log
echo "=================================" >> /tmp/init.log
echo "=================================" >> /tmp/init.log
curl -L https://bootstrap.saltstack.com -o install_salt.sh  >> /tmp/init.log
sudo sh install_salt.sh -P  >> /tmp/init.log

echo "master: ${masterNode}" > /etc/salt/minion.d/minion.conf
echo "id: ${minionId}" >> /etc/salt/minion.d/minion.conf
echo "master_port: 4506" >> /etc/salt/minion.d/minion.conf
echo "publish_port: 4505" >> /etc/salt/minion.d/minion.conf
echo "saltenv: ${minionEnv}" >> /etc/salt/minion.d/minion.conf
echo "state_top_saltenv: ${minionEnv}" >> /etc/salt/minion.d/minion.conf
echo "default_top: ${minionEnv}" >> /etc/salt/minion.d/minion.conf
echo "test: False" >> /etc/salt/minion.d/minion.conf

systemctl enable salt-minion  >> /tmp/init.log
systemctl restart salt-minion  >> /tmp/init.log

echo "Cloud init end at: `date`" >> /tmp/init.log