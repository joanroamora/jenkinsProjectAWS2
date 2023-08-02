# DevOps Project #3

Hello, this time we are going to deploy a super simple application on a server, from an EC2 virtual machine provided by the free AWS layer. In this development we will use several infrastructure and automation tools such as Jenkins, Ansible and Terraform. All deployed on Amazon cloud services. 


# Steps

The first thing we have to do is to deploy an EC2 virtual machine, in which we will have access to a public subnet, and we will configure the security group with an allowed entry to the machine through port 22, in order to access the VM via SSH. The image we will use in this case is the Amazon-Linux image, which has been updated in 2023, and requires some details in terms of package handling that we will reveal in the next lines. For this case we will use a virtual machine with 1gb of ram memory and a single Vcpu.

## Join to your VM 

You should try to enter the virtual machine that you deployed in step one, to do this download the private keys at the time of instance creation, and connect through any of the ways that are allowed for SSH connection.

## Java 11 Installation

For this particular step you must be careful. In this exercise we have used an Amazon-Linux image, which has been updated this 2023, which resulted in the impossibility to install the Java Development Kit package in its version 11, through the default package manager DNF. To solve this problem we are going to use Amazon Coretto: "Amazon Corretto is a distribution of the Open Java Development Kit (OpenJDK) developed and maintained by the Amazon Web Services (AWS) Team. This is designed to use on the AWS Linux platform to get a number of benefits when running Java applications."

 1. **Amazon Coretto - Java11 instalation :** sudo dnf install java-11-amazon-corretto-devel
 2. **Check your installation was succesfuly :** java -version
 3. **If for some reason it becomes necessary for you to switch between Java versions, use:** alternatives --config java

## Jenkins Installation

Once you have made sure that the Java JDK 11 is installed, we proceed with the installation of Jenkins:

 1. **Download the package:** sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
 2. **Import the key** :  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
 3. **Update the repository** :sudo dnf upgrade
 4. **Jenkins installation**: sudo dnf install jenkins
 5. **Reload the service**: sudo systemctl daemon-reload
 6. **If you want to configure Jenkins to run as soon as you start the VM:** 
sudo systemctl enable jenkins
7. **Start Jenkins:** sudo systemctl start jenkins
8. **Check the Jenkins status** : sudo systemctl status jenkins


## Set up your Jenkins server

Once you run the command to start the Jenkins service, you will have access to the control panel through the public IP of your EC2 instance on port 8080. It is important that you check your security group in order to customize the configuration to allow access from your browser. 

 1. Configure the security groups to allow traffic from the query IP and through port 8080.
 2. Verify the **password** predefined by the application, and enter it in the space provided in the browser: sudo cat /var/lib/jenkins/secrets/initialAdminPassword.
 3. Install the necessary plugins.
 4. Make the basic data configuration. 
 5. Then, click on start using Jenkins. Enjoy!

## Install Git and Terraform on your Jenkins Server

You can install GIT via SSH. For this just get the connection and then run the next command: 
sudo dnf install git

Now, for the Terraform instalation:
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

and

sudo yum -y install terraform

## Ansible installation
Its possible that you find some troubles to install Ansible on your Amazon Linux 2023 EC2 VM, for this just take care of use the next commands:

python3  -m  pip  -V

If the console output is negative, you need to install the pip package handler like this:

curl  https://bootstrap.pypa.io/get-pip.py  -o  get-pip.py
python3  get-pip.py  --user

Now yes, installing Ansible:
python3  -m  pip  install  --user  ansible

## Pass the parameters

Make sure to enter the parameter settings inside your job in Jenkins. In this place you will be able to give values to the parameters that you will pass to your system before starting the execution.

![enter image description here](https://i.stack.imgur.com/fdL9V.png)

