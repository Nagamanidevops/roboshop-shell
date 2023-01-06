scriptLocation=$(pwd)

LOG=/tmp/roboshop.log
echo -e "\e[35m install nginx\e[0m"
yum install nginx -y &>>${LOG}

if [ $? -eq 0 ]; then
echo success
else
echo failed
fi

echo -e "\e[31m remove nginx old content\e[0m"
rm -rf /usr/share/nginx/html/* 
echo $?

echo -e "\e[32mdownload frontend content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
echo $?

cd /usr/share/nginx/html &>>${LOG}

echo -e "\e[33mextract frontend content \e[0m"
unzip /tmp/frontend.zip &>>{LOG}
echo $?

echo $scriptLocation
echo -e "\e[34mcopy nginx roboshop config file\e[0m"
cp ${scriptLocation}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
echo $?
echo -e "\e[36m ENABLE nginx\e[0m" 
systemctl enable nginx &>>${LOG}
echo $?

echo -e "\e[36m start nginx\e[0m"

systemctl restart nginx &>>${LOG}
echo $?