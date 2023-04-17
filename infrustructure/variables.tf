
variable "host" {
    type = string
    description = "Host url for the remote connection to the ansible not"
    default = "192.168.8.133"
  
}

variable "password" {
    type = string
    description = "Password for the ansible control node"
    default =  "password"
 
}

variable "vpc_cidr" {
    type = string
    description = "VPC cidr block"
    default = "10.0.0.0/16"
}

variable "instance_type" {
    default = "t2.micro"
  
}