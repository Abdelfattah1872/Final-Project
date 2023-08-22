# DevOps-Capstone-Project 
# 🎉 DevOps-Capstone-Project 🎉

## ✨ Introduction

The DevOps Bootcamp Capstone Project aims to create a fully automated CI/CD pipeline for a web application running on Kubernetes. The project utilizes various tools and technologies such as Terraform, Ansible, Docker, and Kubernetes to achieve the objective.

![image](https://user-images.githubusercontent.com/28235504/226341088-c1baa419-ec1d-4258-807c-d81d61ab9d1c.png)

## Prerequisites:
- ✅  Git
- ✅  Terraform
- ✅  Ansible
- ✅  Docker 
- ✅  Docker Compose
- ✅  Kubernetes
- ✅  AWS
- ✅  Jenkins


# 🏗️ To set up the project, follow these steps:

- Clone the project repository to your local machine.
- Navigate to the project directory.
- Run Terraform to create VPC with 3 Subnet in 2 AZs, EKS cluster with two nodes, an EC2 machine for Jenkins, and an ECR.
    - To initialize Terraform: ``` terraform init ```
    - To execute a Terraform plan: ``` terraform plan ```
    - To apply the Terraform plan and build the infrastructure: ``` terraform apply ```

- Use Ansible to install and configure Jenkins, including necessary plugins.
    - ``` ansible-playbook install_jenkins.yml inventory.ini  ```
    - ``` ansible-playbook install_awscli.yml -i inventory.ini  ```
    - ```ansible-playbook install_kubectl.yml -i inventory.ini  ```


- RUN docker compose up in flask_app dir for the code and database to run app.
    - ``` docker compose up ```

- After completing the necessary steps outlined in the previous sections,You can run the pipeline.



## Tasks Completed
- Used Terraform to create VPC with 3 Subnet in 2 AZs,EKS cluster with two nodes, an EC2 machine for Jenkins, ECR and run Ansible playbook for configure jenkins and plugins.
- Used Ansible to install Docker, Java, awscli, Kubectl.
- Created webhook for jenkins and GitHub for automated initiation of the pipeline.
- Created a Docker images and Pushed them to the ECR repos.
- Created Kubernetes deployment files for the Python code and statefulset files for MySQL, with PV and PVCs. Added services, configmaps, and secrets for the code, and used an NGINX controller for ingress.
- Configured Jenkins using pipeline as a code to build from GitHub on every push on all branches (GitHub webhooks) to integrate with Jenkins.
- Build the CI/CD Pipeline using Jenkins.
    - Checkout external project 🙈
    - build new Docker images
    - push the image to ECR
    - add image to the yml files app and database
    - 🚀 Deploy Kubernetes manifest files. 
    - 🚀 the pipeline is configured to output the URL to the website.




## Conclusion
The successful completion of this project highlights the importance of DevOps practices in modern software development. By automating the deployment process, teams can save time, reduce errors, and improve overall productivity. The use of tools like Terraform, Ansible, Docker, and Kubernetes streamlines the process of deploying and scaling applications, making it easier for teams to manage complex infrastructures.


## Manual Steps.
1- adding Jenkins user to docker group 
######   
    - sudo usermod -aG docker jenkins
    - sudo service jenkins restart
    - ansible-playbook install_kubectl.yml -i inventory.ini

2- adding the aws configure command with jenkins user to configure jenjins user authentication to AWS
######
    - aws configure

3- Kubctl ApiVersion issue when using kubectl
######
    - curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
    - chmod +x ./kubectl
    - sudo mv ./kubectl /usr/local/bin/kubectl
    - sudo kubectl version


Screenshots 

Pipline Sucessfully uning.
![image]![Screenshot from 2023-08-16 15-46-47](https://github.com/Abdelfattah1872/Full-Flask-App/assets/57042795/d338af73-4cd7-4874-9c03-48f3206f14b1)



Application Up and runing
![image](![Screenshot from 2023-08-16 15-47-36](https://github.com/Abdelfattah1872/Full-Flask-App/assets/57042795/857403ab-abd1-400d-b313-01fb298af362)
