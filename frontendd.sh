scriptLocation=$(pwd)

LOG=/tmp/roboshop.log
echo -e "\e[35m install nginx\e[0m"
yum install nginx -y &>>${LOG}



rm -rf /usr/share/nginx/html/* 

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}

cd /usr/share/nginx/html &>>${LOG}

unzip /tmp/frontend.zip

echo $scriptLocation

cp ${scriptLocation}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}

 
systemctl enable nginx &>>${LOG}

systemctl restart nginx &>>${LOG}