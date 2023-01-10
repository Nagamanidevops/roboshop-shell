source common.sh

component=dispatch

if [ -z ${roboshop_rabbitmq_password} ]; then
 echo "roboshop_rabbitmq_password is missing"
 exit
fi 
echo  ${roboshop_rabbitmq_password}

print_head "install golang"
yum install golang -y
status_check

APP_PREREQ


cd /app 
print_head "download dependencies"
go mod init dispatch >>$LOG
status_check

print_head "go get"
go get
status_check

print_head "build content"
go build
status_check

print_head "reload deamont"
systemctl daemon-reload
status_check

print_head "enable golang"
systemctl enable dispatch 
status_check


print_head "start golang"
systemctl start dispatch
status_check
