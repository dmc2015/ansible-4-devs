
shell-script.sh
#running script


ansible-playbook playbook.yml
#start playbook

ansible-playbook playbook.yml --check
#checks to see if what is in the playbook is actually on the hosts, it does not run anything

ansible-playbook playbook.yml --limit webservers
#limits the vm's that the playbook will be run on to just one group

ansible-playbook playbook.yml --limit example.com
#runs playbook on one server

ansible-playbook playbook.yml --list-hosts
#shows you the hosts that this playbook will be run on

ansible-playbook playbook.yml --remote-user=johndoe
# -u johndoe, setups a remote user to run the playbook as
#If no user is assigned in the playbook ansible will assume you are using the user name that is defined in the inventory for that particular host. If that is not setup eaither it will use the local user account name.


--ask-sudo-pass -K 
#allows you to enter password for command

--sudo
#runs all commands as if the user is sudo

--sudo-user=janedoe -U
#runs commands as a sudo user

#OTHER PARAMETERS
--inventor=PATH or -i

--verbose or -v

--extra-vars=VARS -e VARS

--forks=NUM -f NUM

--connectino=TYPE -c TYPE

--check
