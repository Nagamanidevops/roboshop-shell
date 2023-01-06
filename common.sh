scriptLocation=$(pwd)
LOG=/tmp/roboshop.log

status_check(){
 if [ $? -eq 0 ]; then
  echo -e "\e[32success\e[0m"
 else
  echo -e "\e[31m failed js\e[0m"
  echo "refer log file , LOG - ${LOG}"
  exit
 fi
}