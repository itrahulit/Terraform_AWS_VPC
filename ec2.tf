resource "aws_instance" "publicec2" {

ami = "ami-04a2d6660f1296314"
instance_type = "t2.micro" 
vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
subnet_id = "${aws_subnet.publicsubnet_a.id}"
key_name = "raksv-terra"
tags = {
    Name = "publicec2"
}  

depends_on = ["aws_vpc.mainvpc","aws_subnet.publicsubnet_a"] 
}

resource "aws_instance" "privateec2" {
  ami = "ami-04a2d6660f1296314"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  subnet_id = "${aws_subnet.privatesubnet_a.id}"
  key_name = "raksv-terra"
  tags = {
      Name = "privateec2"
  }
  depends_on = ["aws_vpc.mainvpc","aws_subnet.privatesubnet_a"]
}

