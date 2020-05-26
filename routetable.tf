resource "aws_route_table" "Publicroutetable" {
  vpc_id = "${aws_vpc.mainvpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw_tf.id}"
  }
  tags = {
      Name = "PublicRouteTable"
  }
  depends_on = ["aws_vpc.mainvpc","aws_internet_gateway.igw_tf"]
}

resource "aws_route_table_association" "publicroutetableassociatiom" {
  subnet_id = "${aws_subnet.publicsubnet_a.id}"
  route_table_id = "${aws_route_table.Publicroutetable.id}"
    depends_on = ["aws_subnet.publicsubnet_a","aws_route_table.Publicroutetable"]
}

resource "aws_route_table" "privateroutetable" {
  vpc_id = "${aws_vpc.mainvpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_nat_gateway.my_natgateway.id}"
  }
  tags = {
      Name = "privateroutetable"
    
  }
  depends_on = ["aws_vpc.mainvpc","aws_nat_gateway.my_natgateway"]
}
resource "aws_route_table_association" "privateroutetableassociation" {
  subnet_id = "${aws_subnet.privatesubnet_a.id}"
  route_table_id = "${aws_route_table.privateroutetable.id}"
depends_on = ["aws_subnet.privatesubnet_a","aws_route_table.privateroutetable"]

}

