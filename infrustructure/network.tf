resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}


resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  depends_on = [ aws_vpc.this ]
  tags = {
    Name = "ansible-terraform-igw"
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
   tags = {
    Name = "ansible-terraform-route-tb"
  }
}

resource "aws_route" "this" {
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}


resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.0.0/28"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true


  depends_on = [ aws_vpc.this ]

  tags = {
    
    Name = "public-subnet"
    Description = "Public subnet"
  }
}

resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id

}

resource "aws_security_group" "this" {
  name        = "AnsibleTerraformSecGroup"
  vpc_id      = aws_vpc.this.id
  description = "This is the security group for the ansibleTerraform"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  } 
    ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  } 

  egress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    cidr_blocks = [ "0.0.0.0/0" ]
  }
    depends_on = [ aws_vpc.this ]
}


