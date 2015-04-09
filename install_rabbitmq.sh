#!/bin/bash

echo "Note: This tiny script has been hardcoded specifically for RHEL/CentOS, RabbitMQ v3.5.1"
echo ""

#Download RabbitMQ and Erlang
yum install wget -y

wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.5.1/rabbitmq-server-3.5.1-1.noarch.rpm
wget https://www.rabbitmq.com/releases/erlang/erlang-17.4-1.el6.x86_64.rpm


#Install Erlang and RabbitMQ
rpm -ivh erlang-17.4-1.el6.x86_64.rpm
rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
yum install rabbitmq-server-3.5.1-1.noarch.rpm -y 


chkconfig rabbitmq-server on
/sbin/service rabbitmq-server start

rabbitmqctl change_password guest welcome123

rabbitmq-plugins enable rabbitmq_management

#Steps to Configure Clustering between two rabbitmq servers
#scp -pr /var/lib/rabbitmq/.erlang.cookie rabbitmq-server2:/var/lib/rabbitmq/
#chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
#rabbitmqctl stop_app
#rabbitmqctl join_cluster rabbit@rabbitmq-server1
#rabbitmqctl start_app


#To configure Queue mirroring on RabbitMQ
#rabbitmqctl set_policy ha-all '^(?!amq\.).*' '{"ha-mode": "all"}'


rabbitmqctl status

echo ".... Now check the RabbitMQ management console at http://YourIPAddress:15672 ...."
