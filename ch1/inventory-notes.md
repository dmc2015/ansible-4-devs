


NOTES
[NAME OF THE GROUP THAT WILL BE CALLED ON WHEN MANAGING MULTIPLE SERVERS]

Names that follow the group names are servers in the group, they can also be IP addresses
If you want to access the server via ssh on another port besides 22 you will need to
specify it here.

Ex: www.example.com:2222

ansible does not check the ssh config for ports, only the inventory


Note you have to run a command after sourcing .bashrc b/c each ssh session is distinct - every ansible command runs in a separate ssh transaction.
