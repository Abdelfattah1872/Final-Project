######################### EC2 ###########################
######################### NETWORK ###########################

# Create a VPC for the EC2
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "tf" }
}
# Create a new Subnet for the EC2
resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/24"
  tags = { Name = "tf" }
}
# Create a IGW for the EC2
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = { Name = "tf" }
}
# Create a Route Table for the EC2
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = { Name = "tf" }
}
resource "aws_route_table_association" "public-rt-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

########################## NETWORK ###########################

data "aws_ami" "jenkins" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "aws-linux-sg" {
  name        = "linux-sg"
  description = "Allow all incoming traffic to the Linux EC2 Instance"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535  # Allow all ports
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all incoming TCP traffic"
  }

  ingress {
    from_port   = 0
    to_port     = 65535  # Allow all ports
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all incoming UDP traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"    # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outgoing traffic"
  }

  tags = { Name = "tf" }
}

resource "aws_instance" "linux-server" {
  ami                         = data.aws_ami.jenkins.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.aws-linux-sg.id]
  key_name = "ans-key"
  associate_public_ip_address = true
  source_dest_check           = false
  tags = { Name = "jenkins" }
}

# Provisioner to extract and save the public IP in a text file
resource "null_resource" "public_ip_extractor" {
  provisioner "local-exec" {
    command = "echo '${aws_instance.linux-server.public_ip}' > ec2_public_ip.txt"
  }

  depends_on = [aws_instance.linux-server]
}

