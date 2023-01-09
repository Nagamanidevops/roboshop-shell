scriptLocation=$(pwd)
LOG=/tmp/roboshop.log

status_check()
{
 if [ $? -eq 0 ]; then
  echo -e "\e[1;32m success\e[0m"
 else
  echo -e "\e[1;31m FAILURE\e[0m"
  echo "refer log file , LOG - ${LOG}"
  exit 1
 fi
}

print_head()
{
    echo -e "\e[1m $1 \e[0m"
}


NODEJS(){
 print_head "configuring nodejs repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check

print_head "install Node js"
yum install nodejs -y &>>${LOG}
status_check

print_head "add application user"
id roboshop &>>${LOG}
if [ $? -ne 0 ] ; then
useradd roboshop &>>${LOG}
fi

mkdir -p /app &>>${LOG}

print_head "downloading app conten"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${LOG} 
status_check

 print_head "m cleanup old content"
status_check

rm -rf /app/*

print_head "extracting app content"
cd /app 
unzip /tmp/${component}.zip &>>${LOG}
status_check



print_head " installing Node js dependencie"
cd /app 
npm install &>>${LOG}
status_check



print_head " installing Node js dependencie"
cp ${scriptLocation}/files/${component}.service /etc/systemd/system/${component}.service &>>${LOG}
status_check


print_head "system d"
systemctl daemon-reload &>>${LOG}
status_check


print_head "enable ${component} service"
systemctl enable ${component} &>>${LOG}
status_check


print_head "start ${component} service"
systemctl start ${component} &>>${LOG}
status_check

 if [ $schema_load} == "true" ] ; then
  print_head "configuring mongo repo"
  cp ${scriptLocation}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
  status_check
  
  print_head "install mongo client"
  yum install mongodb-org-shell -y &>>${LOG}
  status_check
  
  print_head "load schema"
  mongo --host mongodb-dev.devopsg70.online  </app/schema/${component}.js &>>${LOG}
  status_check
 fi

}

 



