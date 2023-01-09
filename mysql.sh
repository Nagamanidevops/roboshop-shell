source common.sh

if [ -z ${root_mysql_password} ]; then
 echo "root_mysql_password is missing"
 exit
fi 
echo  ${root_mysql_password}

print_head "disable mysql 8.0"
dnf module disable mysql -y &>>${LOG}
status_check

print_head "Copy MySQL Repo file"
cp ${scriptLocation}/files/mysql.repo /etc/yum.repos.d/mysql.repo
#cp ${scriptLocation}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>>${LOG}
status_check
  
 print_head "Install mysql 8.0"
 yum install mysql-community-server -y &>>${LOG}
 status_check
  
  
 print_head "Enable mysql 8.0"
 systemctl enable mysqld &>>${LOG}
 status_check
  
 
 print_head "Start mysql 8.0"
 systemctl start mysqld &>>${LOG}
 status_check
 
 print_head " Reset default  database sql password"
 mysql_secure_installation --set-root-pass ${root_mysql_password} &>>${LOG}
 status_check
 