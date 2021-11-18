ip_address=`wget -qO- http://ipecho.net/plain | xargs echo`
sys_date=`date`
echo "\n\n -------------> ${sys_date}\n"
echo "public IP : ${ip_address}\n" >> /var/log/duck.log
echo url="https://www.duckdns.org/update/homectos/9317c1a4-43b3-4815-81d9-e8a203bfa277/${ip_address}" | curl -k --append /var/log/duck.log -K -
