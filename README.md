# System check
This project serves as a solution to a professional test. I created it to demonstrate my technical skills and expertise. The original task description is provided below.

## DevOps Technical Test
Please note that it is okay to provide simplified solutions. Go as far as you can! The purpose is to demonstrate your proficiency in key areas relevant to the job.

If the task descriptions are not clear, please send your questions in email to clarify the requirements!

Please zip your files and send that zip to us (or you might create a GitHub repository to share your solution).

You are also encouraged to add comments to your code or explain your solution in a Readme file!

### Task 1 - Scripting test
#### Objective:
Write a standalone script that checks if the current system meets the following minimum requirements:
- Ubuntu 20.04 LTS ("Focal Fossa"): later versions are not supported yet
- 8 vCPUs: a CPU with AVX support is required
- 16 GB RAM
- 32 GB Free Disk Space

#### Task:
- Implement your solution in a common scripting language that is pre-installed on Ubuntu 20 (Bash or Python solutions are preferred)
- Feel free to use rounded values (e.g. 15.8 GB RAM is good enough)
- Check each requirement and output the current value on the system and the required value. Please format the output to be easily readable!
- Print a final verdict at the end: PASSED or FAILED (if we had at least one missing requirement)

## Running
Run ```./system_check.sh``` from its directory for system check.

## Testing from Vagrant
If you have Vagrant and VirtualBox, you can test system check on several systems easily.

Use ```vagrant up``` command to start a VM and then ```vagrant ssh``` to login the VM via SSH.

You can find the system check script in ```/vagrant/``` directory on the VM.

You can modify ```Vagrantfile``` to try system check with other distributions/versions/RAM size/CPU number.

You can destroy the VM if not needed anymore with ```vagrant destroy```.

If you use Windows as host machine and have timeout after ```vagrant up``` (while ```default: SSH auth method: private key```), try open VirtualBox GUI, leave it in the background and run ```vagrant up``` again.

More information about Vagrant:<br />
[Documentation | Vagrant | HashiCorp Developer](https://developer.hashicorp.com/vagrant/docs)
