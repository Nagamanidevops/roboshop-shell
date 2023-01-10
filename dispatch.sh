source common.sh

component=dispatch

if [ -z ${roboshop_rabbitmq_password} ]; then
 echo "roboshop_rabbitmq_password is missing"
 exit
fi 
echo  ${roboshop_rabbitmq_password}

print_head "install golang"
yum install golang -y >>$LOG
status_check

#APP_PREREQ
print_head "add application user"
  id roboshop &>>${LOG}
  if [ $? -ne 0 ] ; then
   useradd roboshop &>>${LOG}
  fi
  status_check
  
mkdir /app 
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app 
unzip /tmp/dispatch.zip

cd /app 
print_head "download dependencies"
go mod init dispatch >>$LOG
status_check

print_head "go get"
go get >>$LOG
status_check

print_head "build content"
go build >>$LOG
status_check

print_head "reload deamont"
systemctl daemon-reload >>$LOG
status_check

print_head "enable golang"
systemctl enable dispatch >>$LOG
status_check


print_head "start golang"
systemctl start dispatch >>$LOG
status_check
