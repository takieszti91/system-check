# System check
This Bash script can check some system parameters and compare to the required values.

## Running
Run ```./system_check.sh``` from its directory for system check.

## Testing from Vagrant
If you have Vagrant and VirtualBox, you can test system check on several systems easily.

Use ```vagrant up``` command to start a VM and then ```vagrant ssh``` to login the VM via SSH.

You can find the system check script in ```/vagrant/``` directory on the VM.

You can modify ```Vagrantfile``` to try system check with other distributions/versions/RAM size/CPU number.

More information about Vagrant:<br />
[Documentation | Vagrant | HashiCorp Developer](https://developer.hashicorp.com/vagrant/docs)