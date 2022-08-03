provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name = "vector-vra-tf-example"
  }
}
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.31.10.0/24"
  availability_zone = "ap-southeast-2b"
  tags = {
    Name = "vector-vra-tf-example"
  }
}
resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.31.10.100"]
  tags = {
    Name = "primary_network_interface"
  }
}
resource "aws_instance" "foo" {
  ami           = "ami-07ec7aee8a573b2ae" # ap-southeast-2b
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
  tags = {
    Name = "Moad Application"
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
}