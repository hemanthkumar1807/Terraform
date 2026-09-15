resource "aws_vpc" "dev1" {
         cidr_block = "10.0.0.0/16" 
         tags = {
           Name = "demo_terraform_vpc1"
         }  
}

resource "aws_subnet" "dev1_subnet" {
      vpc_id            = aws_vpc.dev1.id
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      tags = {
        Name = "demo_terraform_subnet1"
      }
}

resource "aws_internet_gateway" "dev1_igw" {
      vpc_id = aws_vpc.dev1.id
      tags = {
        Name = "demo_terraform_igw1"
      }
}

resource "aws_route_table" "dev1_rt" {
      vpc_id = aws_vpc.dev1.id
      tags = {
        Name = "custom_rt"
      }
      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev1_igw.id
      }
}

resource "aws_route_table_association" "dev1_rta" {
      subnet_id      = aws_subnet.dev1_subnet.id
      route_table_id = aws_route_table.dev1_rt.id
}

resource "aws_security_group" "dev1_sg" {
      name        = "demo_terraform_sg1"
      description = "Allow SSH and HTTP"
      vpc_id      = aws_vpc.dev1.id

      ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" #any protocol
        cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "dev1_instance" {
      ami                    = "ami-0e34b50e714a297f1"
      instance_type          = "t3.micro"
      subnet_id              = aws_subnet.dev1_subnet.id
      vpc_security_group_ids = [aws_security_group.dev1_sg.id]
      tags = {
        Name = "demo_terraform_instance1"
      }
}
