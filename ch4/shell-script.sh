yum install --quiet -y httpd httpd-devel
#install httpd 


cp httpd.conf /etc/htpd/conf/httpd.conf
cp httpd-vhosts.conf /etc/httpd/conf/httpd-vhosts.conf
# cp httpd configs to root position

service httpd start
chkconfig httpd on
#start httpd service and configure it to run on boot on line 10
