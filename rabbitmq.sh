source common.sh

if [ -z ${roboshop_rabbitmq_password} ]; then
 echo "roboshop_rabbitmq_password is missing"
 exit
fi 
echo  ${roboshop_rabbitmq_password}

print_head "configuring erlang repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>>${LOG}
status_check

print_head "configuring rabbitmq repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${LOG}
status_check

#yum install erlang -y
print_head "install rabbitmq &erlang"
yum install rabbitmq-server -y &>>${LOG}
status_check

print_head "enable mysql 8.0"

systemctl enable rabbitmq-server &>>${LOG}
status_check


print_head "start mysql 8.0"
systemctl start rabbitmq-server &>>${LOG} 
status_check

print_head "add application user"
rabbitmqctl add_user roboshop ${roboshop_rabbitmq_password} &>>${LOG}
status_check

print_head "add tags to application user"
rabbitmqctl set_user_tags roboshop administrator &>>${LOG}
status_check

print_head "add permissions to application user"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${LOG}


