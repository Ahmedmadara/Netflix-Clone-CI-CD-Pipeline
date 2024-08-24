provider "aws" {
  region = "us-east-1"  # Change this to your preferred region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  # Change this as needed
  map_public_ip_on_launch = true
}

resource "aws_security_group" "default" {
  vpc_id = aws_vpc.main.id
}

resource "aws_network_interface" "jenkins_sonar" {
  subnet_id       = aws_subnet.main.id
  private_ips      = ["192.168.30.20"]
  security_groups  = [aws_security_group.default.id]
}

resource "aws_network_interface" "prometheus" {
  subnet_id       = aws_subnet.main.id
  private_ips      = ["192.168.30.21"]
  security_groups  = [aws_security_group.default.id]
}

resource "aws_network_interface" "k8s_master" {
  subnet_id       = aws_subnet.main.id
  private_ips      = ["192.168.30.22"]
  security_groups  = [aws_security_group.default.id]
}

resource "aws_network_interface" "k8s_worker" {
  subnet_id       = aws_subnet.main.id
  private_ips      = ["192.168.30.23"]
  security_groups  = [aws_security_group.default.id]
}

resource "aws_instance" "jenkins_sonar" {
  ami           = "ami-0c55b159cbfafe1f0"  # Update this with a valid Ubuntu AMI for your region
  instance_type = "t2.medium"
  tags = {
    Name = "jenkins-sonar"
  }
  network_interface {
    network_interface_id = aws_network_interface.jenkins_sonar.id
    device_index         = 0
  }
}

resource "aws_instance" "prometheus" {
  ami           = "ami-0c55b159cbfafe1f0"  # Update this with a valid Ubuntu AMI for your region
  instance_type = "t2.medium"
  tags = {
    Name = "prometheus"
  }
  network_interface {
    network_interface_id = aws_network_interface.prometheus.id
    device_index         = 0
  }
}

resource "aws_instance" "k8s_master" {
  ami           = "ami-0c55b159cbfafe1f0"  # Update this with a valid Ubuntu AMI for your region
  instance_type = "t2.medium"
  tags = {
    Name = "k8s-master"
  }
  network_interface {
    network_interface_id = aws_network_interface.k8s_master.id
    device_index         = 0
  }
}

resource "aws_instance" "k8s_worker" {
  ami           = "ami-0c55b159cbfafe1f0"  # Update this with a valid Ubuntu AMI for your region
  instance_type = "t2.medium"
  tags = {
    Name = "k8s-worker"
  }
  network_interface {
    network_interface_id = aws_network_interface.k8s_worker.id
    device_index         = 0
  }
}

