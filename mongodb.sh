scriptLocation=$(pwd)
source common.sh

print_head "copy momgodb repo file"
cp ${scriptLocation}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
status_check

print_head "install MongoDB"
yum install mongodb-org -y &>>${LOG}
status_check

 
print_head "Update MongoDB listen adress"
 sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG}
 status_check
 
print_head "install MongoDB"
systemctl enable mongod &>>${LOG}
status_check

print_head " restart MongoDB"
systemctl restart mongod &>>${LOG}
status_check