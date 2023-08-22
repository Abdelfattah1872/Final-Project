#! /bin/bash
cd terraform
terraform init
terraform apply --auto-approve
cd ../ansible
ansible-playbook -i inventory.py jenkins_install.yml -e "auto_approve=true"