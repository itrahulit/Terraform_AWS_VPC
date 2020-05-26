resource "aws_vpc" "mainvpc" {
  cidr_block = "10.0.0.0/24"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
      Name = "mainvpc_tf"
  }

}

resource "aws_security_group" "allow_ssh" {
  name          = "allow_ssh"
  description   = "allow ssh inbound/allow all outbound"
  vpc_id        = "${aws_vpc.mainvpc.id}"
  ingress {
      from_port  = 22
      to_port    = 22
      protocol   = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  egress {
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "securitygroup_tf" 
  }  

  depends_on = ["aws_vpc.mainvpc"]
  }
resource "aws_internet_gateway" "igw_tf" {
  vpc_id = "${aws_vpc.mainvpc.id}"

  tags = {
      Name = "igw_tf"
  }
  depends_on = ["aws_vpc.mainvpc"]

}

resource "aws_eip" "my_eip_tf" {
    vpc  = true
    tags = {
        Name = "my_eip_tf"
    }
}
resource "aws_nat_gateway" "my_natgateway" {
    allocation_id = "${aws_eip.my_eip_tf.id}"
    subnet_id = "${aws_subnet.publicsubnet_a.id}"

    tags = {
        Name = "my_natgateway"
    }
    depends_on = ["aws_eip.my_eip_tf","aws_subnet.publicsubnet_a"]
}
