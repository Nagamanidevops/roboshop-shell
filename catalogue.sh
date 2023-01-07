source common.sh

print_head "configuring nodejs repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check

print_head "install Node j"
yum install nodejs -y &>>${LOG}
status_check

print_head "add application use"
id roboshop &>>${LOG}
if [$? -ne 0] ; then
useradd roboshop &>>${LOG}
fi

mkdir -p /app &>>${LOG}

print_head "downloading app conten"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG} 
status_check

 print_head "m cleanup old content"
status_check

rm -rf /app/*

print_head "extracting app content"
cd /app 
unzip /tmp/catalogue.zip &>>${LOG}
status_check



print_head " installing Node js dependencie"
cd /app 
npm install &>>${LOG}
status_check



print_head " installing Node js dependencie"
cp ${scriptLocation}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
status_check


print_head "system d"
systemctl daemon-reload &>>${LOG}
status_check


print_head "enable catalogue servic"
systemctl enable catalogue &>>${LOG}
status_check


print_head"start catalogue servic"
systemctl start catalogue &>>${LOG}
status_check


print_head "configuring mongo repo"
cp ${scriptLocation}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check

print_head "install mongo client"
yum install mongodb-org-shell -y &>>${LOG}
status_check

print_head "load schema"
mongo --host mongodb-dev.devopsg70.online  </app/schema/catalogue.js &>>${LOG}
status_check

