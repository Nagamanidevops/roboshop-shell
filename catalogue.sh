source common.sh

print_head "configuring nodejs repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check


#echo -e "\e[36m install Node js\e[0m"
print_head "install Node j"
yum install nodejs -y &>>${LOG}
status_check

print_head "add application use"
useradd roboshop

mkdir -p /app &>>${LOG}

#echo -e "\e[36m downloading app content\e[0m"
print_head "downloading app conten"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG} 
status_check


#echo -e "\e[36m cleanup old content\e[0m"
 print_head "m cleanup old content"
status_check

rm -rf /app/*

#echo -e "\e[36m extracting app content\e[0m"
print_head "extracting app content"
cd /app 
unzip /tmp/catalogue.zip &>>${LOG}
status_check


#echo -e "\e[36m installing Node js dependencies\e[0m"
print_head " installing Node js dependencie"
cd /app 
npm install &>>${LOG}
status_check


#echo -e "\e[36m configuring catalogue service file\e[0m"
print_head " installing Node js dependencie"
cp ${scriptLocation}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
status_check



#echo -e "\e[36m system d\e[0m"
print_head "system d"
systemctl daemon-reload &>>${LOG}
status_check


#echo -e "\e[36m enable catalogue service\e[0m"
print_head "enable catalogue servic"
systemctl enable catalogue &>>${LOG}
status_check


#echo -e "\e[36m start catalogue\e[0m"
print_head"start catalogue servic"
systemctl start catalogue &>>${LOG}
status_check


#echo -e "\e[36m configuring mongo repo\e[0m"
print_head "configuring mongo repo"
cp ${scriptLocation}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check


#echo -e "\e[36m install mongo client\e[0m"
print_head "install mongo client"
yum install mongodb-org-shell -y &>>${LOG}
status_check


#echo -e "\e[36m load schema\e[0m"
print_head "load schema"
mongo --host mongodb-dev.devopsg70.online  </app/schema/catalogue.js &>>${LOG}
status_check

