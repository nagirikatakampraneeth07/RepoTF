resource "aws_vpc" "pranee" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "TFvpc"
  }
}

resource "aws_subnet" "pranee" {
  vpc_id = aws_vpc.pranee.id
  cidr_block = "10.0.0.0/24"
  tags = {
    name = "TFsubnet"
  }
}
resource "aws_subnet" "prane" {
  vpc_id = aws_vpc.pranee.id
  cidr_block = "10.0.1.0/24"
  tags = {
    name = "privateSubnet"
  }
}
resource "aws_internet_gateway" "pranee" {
  vpc_id = aws_vpc.pranee.id
  tags = {
    name = "TFigg"
  }
}
resource "aws_eip" "prane" {
  
}
resource "aws_nat_gateway" "pranee" {
  subnet_id = aws_subnet.prane.id
  allocation_id = aws_eip.prane.id
  tags = {
    name = "Natgateway"
  }
}
resource "aws_route_table" "pranee" {
  vpc_id= aws_vpc.pranee.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pranee.id
  }
}
resource "aws_route_table" "prane" {
  vpc_id = aws_vpc.pranee.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pranee.id
  }
}

resource "aws_route_table_association" "pranee" {
   subnet_id = aws_subnet.pranee.id
   route_table_id = aws_route_table.pranee.id
}
resource "aws_route_table_association" "prane" {
  subnet_id = aws_subnet.prane.id
  route_table_id = aws_route_table.prane.id
  
}

resource "aws_security_group" "pranee" {
  name = "aloow ssh"
  vpc_id = aws_vpc.pranee.id
  tags = {
    name = "TFsg"
  }
ingress { 
    description      = "TLS from VPC" 
    from_port        = 22 
    to_port          = 22 
    protocol         = "TCP" 
    cidr_blocks      = ["0.0.0.0/0"] 
     
  } 
egress { 
    from_port        = 0 
    to_port          = 0 
    protocol         = "-1" 
    cidr_blocks      = ["0.0.0.0/0"] 
     
  }  
 
  }

