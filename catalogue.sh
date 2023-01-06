scriptLocation=$(pwd)
LOG=/tmp/roboshop.log

status_check()
{
if [ $? -eq 0 ]; then
echo -e "\e[32success\e[0m"
else
echo -e "\e[31m failed js\e[0m"
echo "refer log file , LOG - ${LOG}"
exit
fi

}

echo -e "\e[36m configuring Node js\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check()


echo -e "\e[36m install Node js\e[0m"
yum install nodejs -y &>>${LOG}
status_check()


echo -e "\e[36m add application user\e[0m"
useradd roboshop

mkdir -p /app &>>${LOG}

echo -e "\e[36m downloading app content\e[0m"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG} 
status_check()


echo -e "\e[36m cleanup old content\e[0m"
status_check()

rm -rf /app/*

echo -e "\e[36m extracting app content\e[0m"
cd /app 
unzip /tmp/catalogue.zip &>>${LOG}
status_check()


echo -e "\e[36m installing Node js dependencies\e[0m"
cd /app 
npm install &>>${LOG}
status_check()


echo -e "\e[36m configuring catalogue service file\e[0m"
cp ${scriptLocation}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
status_check()


echo -e "\e[36m system d\e[0m"
systemctl daemon-reload &>>${LOG}
status_check()


echo -e "\e[36m enable catalogue service\e[0m"
systemctl enable catalogue &>>${LOG}
status_check()


echo -e "\e[36m start catalogue\e[0m"
systemctl start catalogue &>>${LOG}
status_check()


echo -e "\e[36m configuring mongo repo\e[0m"
cp ${scriptLocation}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check()


echo -e "\e[36m install mongo client\e[0m"
yum install mongodb-org-shell -y &>>${LOG}
status_check()


echo -e "\e[36m load schema\e[0m"
mongo --host mongodb-dev.devopsg70.online  </app/schema/catalogue.js &>>${LOG}
status_check() 

