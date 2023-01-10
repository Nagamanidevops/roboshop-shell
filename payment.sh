source common.sh

component=payment
schema_load=false
#schema_type=mongo

if [ -z ${roboshop_rabbitmq_password} ]; then
 echo "roboshop_rabbitmq_password is missing"
 exit
fi 
echo  ${roboshop_rabbitmq_password}

PYTHON
