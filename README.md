# Deployment of a simple web app using Ansible Terraform 
Terraform was used to provision a full ec2 and network infrastructure for deploying a simple web application.
This project has two main directories; Infrastructure and Automation.

# Infrastructure is the basic configuration of the AWS infrastructure onto which the web application will be deployed.

# Automation utilizes Ansible to install apache2 and create directories in which the simple web application would be 
  downloaded and saved in from the github repository.
  And finally takes care of the deployment on the ec2 instance.
