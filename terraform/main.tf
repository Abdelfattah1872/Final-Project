module "EKS" {
    source = "./Modules/EKS"
}

module "EC2" {
    source = "./Modules/EC2"
}

module "ECR" {
    source = "./Modules/ECR"
}