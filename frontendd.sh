
source common.sh


print_head "install nginx"
yum install nginx -y &>>${LOG}

status_check


print_head "remove nginx old content"
rm -rf /usr/share/nginx/html/* 
status_check


print_head "download frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
status_check

cd /usr/share/nginx/html &>>${LOG}


print_head "extract frontend content"
unzip /tmp/frontend.zip &>>{LOG}
status_check

echo $scriptLocation

print_head " copy nginx roboshop config file"
cp ${scriptLocation}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

print_head "ENABLE nginx"
systemctl enable nginx &>>${LOG}
status_check


print_head" start nginx"

systemctl restart nginx &>>${LOG}
status_check