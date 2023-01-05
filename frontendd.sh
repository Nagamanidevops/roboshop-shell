scriptLocation=$(pwd)
echo -e "\e[35m install nginx\e[0m"
yum install nginx -y 



rm -rf /usr/share/nginx/html/* 

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
ur
cd /usr/share/nginx/html 

unzip /tmp/frontend.zip

echo $scriptLocation

cp ${scriptLocation}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

 
systemctl enable nginx 

systemctl restart nginx 