source common.sh

component=dispatch
schema_load= false


if [ -z ${roboshop_rabbitmq_password} ]; then
 echo "roboshop_rabbitmq_password is missing"
 exit
fi 
echo  ${roboshop_rabbitmq_password}

print_head "install golang"
yum install golang -y >>$LOG
status_check

APP_PREREQ
SYSTEMD_SETUP

 