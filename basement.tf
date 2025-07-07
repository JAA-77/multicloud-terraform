
// Crear las VPCs spokes y las instancias EC2 de ellas

resource "aws_vpc" "defender_vpc" { 
  cidr_block = "192.168.20.0/24"
  tags = {
    Name = "Defender VPC"
    proyecto = var.proyecto
  }
}

resource "aws_vpc" "attacker_vpc" {
  cidr_block = "192.168.21.0/24"
  tags = {
    Name = "Attacker VPC"
    proyecto = var.proyecto
  }
}

resource "aws_subnet" "defender_subnet_pub" {
  vpc_id            = aws_vpc.defender_vpc.id
  cidr_block        = "192.168.20.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "Defender Subnet Public"
    proyecto = var.proyecto
  }
  var.spoke_vpcs=aws_vpc.defender_vpc.id
}

resource "aws_subnet" "attacker_subnet_pub" {
  vpc_id            = aws_vpc.attacker_vpc.id
  cidr_block        = "192.168.21.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "Attacker Subnet Public"
    proyecto = var.proyecto
  }
}

resource "aws_internet_gateway" "defender_igw" {
  vpc_id = aws_vpc.defender_vpc.id
  tags = {
    Name = "Defender IGW"
    proyecto = var.proyecto
  }
}

resource "aws_internet_gateway" "attacker_igw" {
  vpc_id = aws_vpc.attacker_vpc.id
  tags = {
    Name = "Attacker IGW"
    proyecto = var.proyecto
  }
}

resource "aws_route_table" "defender_pub_rt" {
  vpc_id = aws_vpc.defender_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.defender_igw.id
  }
  tags = {
    Name = "Defender Pub RT"
    proyecto = var.proyecto
  }
}

resource "aws_route_table" "attacker_pub_rt" {
  vpc_id = aws_vpc.attacker_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.attacker_igw.id
  }

  tags = {
    Name = "Attacker Pub RT"
    proyecto = var.proyecto
  }
}

resource "aws_route_table_association" "defender_pub_rt_assoc" {
  subnet_id      = aws_subnet.defender_subnet_pub.id
  route_table_id = aws_route_table.defender_pub_rt.id
 // route_table_id = terraform.workspace == "basement" ? aws_route_table.defender_pub_rt.id : aws_route_table.defender_pub_rt.id
}

resource "aws_route_table_association" "attacker_pub_rt_assoc" {
  subnet_id      = aws_subnet.attacker_subnet_pub.id
  route_table_id = aws_route_table.attacker_pub_rt.id
  // route_table_id = terraform.workspace == "basement" ? aws_route_table.attacker_pub_rt.id : aws_route_table.attacker_pub_rt.id  
}

resource "aws_instance" "defender_instance" {
    ami                  = "ami-0fab1b527ffa9b942"
    instance_type        = "t2.micro"
    subnet_id            = aws_subnet.defender_subnet_pub.id
    security_groups      = [aws_security_group.defender_sg.id]
    iam_instance_profile = aws_iam_instance_profile.mcd_ec2_role_profile.name
    associate_public_ip_address = true
    key_name             = var.aws_key_pair

    ebs_block_device {
        device_name = "/dev/xvda"
        encrypted   = true
        volume_size = 8
        volume_type = "gp3"
    }

    user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install -y nginx
        service nginx start
        chkconfig nginx on
    EOF

    tags = {
        Name = "Defender Instance"
        proyecto = var.proyecto
    }
}

resource "aws_instance" "attacker_instance" {
    ami                  = "ami-0fab1b527ffa9b942"
    instance_type        = "t2.micro"
    subnet_id            = aws_subnet.attacker_subnet_pub.id
    security_groups      = [aws_security_group.attacker_sg.id]
    iam_instance_profile = aws_iam_instance_profile.mcd_ec2_role_profile.name
    associate_public_ip_address = true
    key_name             = var.aws_key_pair

    ebs_block_device {
        device_name = "/dev/xvda"
        encrypted   = true
        volume_size = 8
        volume_type = "gp3"
    }

    user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install -y nmap
    EOF

    tags = {
        Name = "Attacker Instance"
        proyecto = var.proyecto
    }
}

resource "aws_iam_instance_profile" "mcd_ec2_role_profile" {
  role = aws_iam_role.mcd_ec2_role.name
}

resource "aws_iam_role" "mcd_ec2_role" {
  name = "MCDEC2RoleForSSM"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_policy_attachment" {
  role       = aws_iam_role.mcd_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_security_group" "defender_sg" {
  name        = "Defender Security Group"
  description = "Allow outbound access to 0.0.0.0/0 and inbound access to port 80/tcp"
  vpc_id      = aws_vpc.defender_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "attacker_sg" {
  name        = "Attacker Security Group"
  description = "Allow outbound access to 0.0.0.0/0"
  vpc_id      = aws_vpc.attacker_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "defender_instance_id" {
    value = aws_instance.defender_instance.id
}

output "defender_instance_public_ip" {
    value = aws_instance.defender_instance.public_ip
}

output "defender_instance_private_ip" {
    value = aws_instance.defender_instance.private_ip
}

output "attacker_instance_id" {
    value = aws_instance.attacker_instance.id
}

output "attacker_instance_public_ip" {
    value = aws_instance.attacker_instance.public_ip
}

