variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "Cluster_name" {
  description = "Cluster Name"
  type = string
  default = "Giovanni"
}

variable "VPC_name" {
  description = "VPC Name"
  type = string
  default = "VPC_giovanni"
  
}

