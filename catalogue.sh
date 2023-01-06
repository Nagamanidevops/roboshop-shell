scriptLocation=$(pwd)
LOG=/tmp/roboshop.log


echo -e "\e[36m configuring Node js\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi


 echo -e "\e[36m install Node js\e[0m"
yum install nodejs -y &>>${LOG}
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi


echo -e "\e[36m add application user\e[0m"
useradd roboshop
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi



mkdir -p /app &>>${LOG}

echo -e "\e[36m downloading app content\e[0m"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG} 
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi


echo -e "\e[36m cleanup old content\e[0m"
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi

rm -rf /app/*

echo -e "\e[36m extracting app content\e[0m"
cd /app 
unzip /tmp/catalogue.zip &>>${LOG}
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi


echo -e "\e[36m installing Node js dependencies\e[0m"
cd /app 
npm install &>>${LOG}
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi


echo -e "\e[36m configuring catalogue service file\e[0m"
cp ${scriptLocation}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi


echo -e "\e[36m system d\e[0m"
systemctl daemon-reload &>>${LOG}
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi


echo -e "\e[36m enable catalogue service\e[0m"
systemctl enable catalogue &>>${LOG}
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi


echo -e "\e[36m start catalogue\e[0m"
systemctl start catalogue &>>${LOG}
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi


echo -e "\e[36m configuring mongo repo\e[0m"
cp ${scriptLocation}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi


echo -e "\e[36m install mongo client\e[0m"
yum install mongodb-org-shell -y &>>${LOG}
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi


echo -e "\e[36m load schema\e[0m"
mongo --host mongodb-dev.devopsg70.online  </app/schema/catalogue.js &>>${LOG}
if [ $? -eq 0 ]; then
echo success
else
echo failed
exit
fi

