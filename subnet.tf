resource "aws_subnet" "publicsubnet_a" {
  vpc_id = "${aws_vpc.mainvpc.id}"
  cidr_block = "10.0.0.1/27"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
      Name = "publicsubnet_a"
  }
depends_on = ["aws_vpc.mainvpc"]
}
resource "aws_subnet" "privatesubnet_a" {
  vpc_id = "${aws_vpc.mainvpc.id}"
  cidr_block = "10.0.0.34/27"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = false

  tags = {
      Name = "privatesubnet_a"
  }
depends_on = ["aws_vpc.mainvpc"]
}
