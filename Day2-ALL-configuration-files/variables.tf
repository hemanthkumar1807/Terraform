variable "cidr" {
    type=string
    default="10.0.0.0/16"
    description="CIDR block for the VPC"
  
}

variable "tags" {
    type=string
    default="dev_vpc"
    description="Tags for the VPC"
}

variable "subnet_cidr" {
    type=string
    default="10.0.0.0/24"
    description="CIDR block for the subnet"
}

variable "subnet_tags" {
    type=string
    default="dev_subnet"
    description="Tags for the subnet"
}