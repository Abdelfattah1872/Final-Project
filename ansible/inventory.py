#!/usr/bin/env python3

import json
import os

def read_ec2_public_ips(file_path):
    with open(file_path, 'r') as f:
        return [ip.strip() for ip in f.readlines() if ip.strip()]

def main():
    file_path = "/home/abdelfattah/Desktop/Final Project/terraform/ec2_public_ip.txt"
    ec2_public_ips = read_ec2_public_ips(file_path)

    inventory = {
        "ec2_instances": {
            "hosts": ec2_public_ips,
            "vars": {
                "ansible_user": "ubuntu",
                "ansible_private_key_file": "/home/abdelfattah/Desktop/Final Project/ansible/ans-key.pem"
            }
        }
    }

    print(json.dumps(inventory))

if __name__ == "__main__":
    main()

