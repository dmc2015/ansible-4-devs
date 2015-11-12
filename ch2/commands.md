vagrant box add geerlingguy/centos7
#downloads a centos box

vagrant init geerlingguy/centos7
#initializes vagrant using the box that was just downloaded.


vagrant up
#provisions vagrant based on onthe vagrantfile that was created with initialization


---
  -hosts: all
   sudo: yes
   tasks:
   - name: Ensure NTP is installed and synched
     yum: name=ntp state=present
   - name: Ensure NTP is running
     service: name=ntpd state=started enabled=yes 

#set up yum installs for provisioning
