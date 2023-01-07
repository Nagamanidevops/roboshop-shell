scriptLocation=$(pwd)
LOG=/tmp/roboshop.log

status_check(){
 if [ $? -eq 0 ]; then
  echo -e "\e[1;32m success\e[0m"
 else
  echo -e "\e[1;31m failed js\e[0m"
  echo "refer log file , LOG - ${LOG}"
  exit
 fi
}

print_head()
{
    echo -e "\e[1m $1 \e[0m"
}