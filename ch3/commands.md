ansible multi -a "hostname"
# performs a check on the ansible hosts in /etc/ansible/hosts
# checks all servers in the multi group based on IP and returns the hosts names
# this uses multiple processing forks, runs asynchronously


ansible multi -a "hostname" -f 1
# '-f 1' tells ansible to perform the hostname check on one server at a time 


ansible multi -a "df -h"
# checks to see the amount of hard drive space that is available on the servers


ansible multi -a "free -m"
# checks to see the amount of free ram that we have on the VM's

ansible multi -a "date"
# check the date and time on each server

ansible multi -m setup
# gives a list in json format of all details for the VM's


ansible multi -s -m yum -a "name=ntp state=present"
#ansible runs a yum installation of ntp, it checks if it is present and if it is not it installs

ansible multi -s -m service -a "name=ntpd state=started enabled=yes"
#checks to see if the service is running, starts if not started and tells machine to start the service on boot.

ansible multi -s -a "service ntpd stop"
#stops ntpd service

ansible multi -s -a "ntpdate -q 0.rhel.pool.ntp.org"
#sets ntp to compare its time with a centralized  time server

ansible multi -s -a "service ntpd start"
#starts ntpd service


ansible app -s -m yum -a "name=MySQL-python state=present"
#installs mysql-python to all app servers

ansible app -s -m yum -a "name=python-setuptools state=present"
#installs all python-setuptools to all app servers


ansible app -s -m  yum -a "name=django state=present"
#author skipped this commnad, it installs django




ansible app -a "python -c 'import django; print django.get_version()'"
#checks the django version


ansible db -s -m yum -a "name=mariadb-server state=present"
#installs mariadb to the db group, using yum, sudo 


ansible db -s -m service -a "name=mariadb state=started enabled=yes"
#checks the mariadb service to see if it is started, if it is not started it starts it and it will start on boot

ansible db -s -a "iptables -F"
#gives you the ip address of the VM, database you are on



ansible db -s -a "iptables -A INPUT -s 192.168.60.0/24 -p tcp -m tcp --dport 3306 -p ACCEPT"
#allows the server to firewall to allow access to mariadbs default port 3306


ansible db -s -m yum -a "name=MySQL-python state=present"
# installs mysql-python

ansible db -s -m mysql_user -a "name=django host=% password=12345 priv=*.*:ALL state=present"
# adds a user with mysql_user module, set the user password


ansible app -s -a "service ntpd stats"
#checks the nptd service to see if it is still running and get additional details

ansible app -s -a "service ntpd restart" -- limit "192.168.60.4"
#restarts the service on one server

ansible app -s -a "service ntpd restart" -- limit "*.4"
#restarts server based on a simple pattern


ansible app -s -a "service ntpd restart" -- limit ~".*\.4"
#restarts server based on regex, hostnames instead ip addresses can be used as well



##########
#MANAGING GROUPS

ansible app -s -m group -a "name=admin state=present"
# other group commands 
  #to remove a group - 'state=absent'
  #to set a group id - 'gid=1234'
  #to indicate the group is a system group - 'system=yes'


ansible app -s -m user -a "name=johndoe group=admin createhome=yes"
# creates a user, adds that user to a group, creates a home directory for that user



ansible app -s -m user -a "name=johndoe group=admin createhome=yes generate_ssh_key=yes"
# creates a user, adds the user to  a group, creates a home directory and then gives the user ssh key
  #other parameters
    uid=134
    shell=bash
    password=
    state=absent remove=yes - deletes the user
    

################
#Managing files and directories


ansible multi -m stat -a
#shows file permissions, md5 and owner of a file, returns info in json


ansible mult -m copy -a "src=/etc/hosts dest=/tmp/hosts"
#copies files from the source to the destination


ansiblemulti -s -m fetch -a "src=/etc/hosts dest=/tmp"
#copies a file from the vm to the host machine, flat=yes can be used also but should only be used with a single host


ansible mult -s -m file -a "dest=/tmp/test mode=644 state=directory"
#creates a directory and sets the security access on that directory


ansible multi -m file -a "src=/src/symlink dest=/dest/symlink owner=root group=root state=link"
#creates a symlinked file

ansible multi -m -s file -a "dest=/tmp/test state=absent"
#deletes a folder or file


################
#Run Operations in the Background

ansible -s -B 3600 -a "yum -y update"
#does a yum update and requires that the update be complted in 3600 seconds

ansible multi -s -m async_status -a "jid=306434204687.20048"
#allows you to check the status of a background job that is runnning

ansible multi -B 3600 -P 0 -a "/path/to/fire-and-forget-script.sh"
#fire and forget tasks, tasks that run in the background and do not get checked for updates, -B is set high and -P is set to '0'
#this prevents ansible async_status from running, but you can check a file for the status update (!/.ansible_async/<jid>)


###########
Common Log File Operations of UNIX in Ansible
tail
cat
grep

Exceptions to these working properly
#-operations that continuously monitor a file, 'tail -f', won't work with ansible. ansible only displays output after the operation is complete, ctrl+c wont' work.(later this feature will be added)
#not a good idea to run a command that has a large amount of data with stdout in Ansible,
#if you redirect a filter output from a command you will need to use the shell module instead of the command module.

PARAMETERS
-a shell command
-m module, followed by the name of the module
-s specifies that the command should be a sudo command, same as --sudo
-K allows ansible to respond with a password when needed, same as --ask-sudo-pass
-B sets the max amount of time to let a job run, this parameter causes the command to be run in the background
-P sets amount of time to wait for polling servers, checking on the status of a job, this parameter causes the command to be run in the background


#NOTES

# sometimes your vm's will need to be able to communicate with one another, for exampel you application servers will need to speak to your database server. In this situation Ansible has tools/modules to allow you to do this(mysql_*).

 
