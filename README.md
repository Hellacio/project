# Big Data Handling Platform 
This project is for Big Data and Cloud Computing courses. The goal of the project is a platform for handling big data that is easy to provision to a cloud service (Google Cloud in our case)

## Requirements
### Terraform
Download the Terraform version from [HERE!](https://www.terraform.io/downloads.html)
(Tested on Terraform 0.12.10)
### Google Cloud account
You can activate one on your normal google account from [HERE!](https://console.cloud.google.com/)
### Project on Google Cloud
[HOWTO](https://cloud.google.com/appengine/docs/standard/nodejs/building-app/creating-project)
### Enable Compute Engine Api for your project
[HOWTO](https://cloud.google.com/service-usage/docs/enable-disable)
### Create account.json
[HOWTO](https://cloud.google.com/iam/docs/creating-managing-service-account-keys)
Get the json format key for the google cloud project you want to use, and rename it account.json
### Create ssh keys
[HOWTO](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
for our project name the public key to: id_rsa.pub

## To provision
1. Clone the repository
2. Move account.json file to the *project* folder (this is used to provision to the correct google cloud project)
3. In variables.tf change the variable project to correspond your own google cloud project name.
4. Move your id_rsa.pub ssh key to the *project* folder (this is used to ssh to the created Compute Engine machines) 
5. Go to the *project* folder on command prompt / terminal
6. Command: _terraform init_
7. To make sure everything as you plan: 
   Command: _terraform plan_
8. To provision:
   Command: _terraform apply_
