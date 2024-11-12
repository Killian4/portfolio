resource "aws_vpc" "vpc1" {
	cidr_block = "10.0.0.0/16"
	enable_dns_hostnames = true
	enable_dns_support = true

	tags = {
		name = "dev"
	}
}

resource "aws_subnet" "public_subnet" {

	vpc_id = aws_vpc.vpc1.id
	cidr_block = "10.0.1.0/24"
	map_public_ip_on_launch = true
	availability_zone = "us-east-1b"
	
	tags = {
		name = "dev"
	}
}

resource "aws_internet_gateway" "internet_gw" {

	vpc_id = aws_vpc.vpc1.id
	tags = {
		name = "dev"
	}
}

resource "aws_route_table" "public_rt" {
	vpc_id = aws_vpc.vpc1.id
	tags = {
		name = "dev"
	}
}

resource "aws_route" "default_route" {
	route_table_id = aws_route_table.public_rt.id
	destination_cidr_block="0.0.0.0/0"
	gateway_id = aws_internet_gateway.internet_gw.id
}

resource "aws_route_table_association" "route_assoc" {
	subnet_id = aws_subnet.public_subnet.id
	route_table_id=aws_route_table.public_rt.id

}
resource "aws_security_group" "sg1" {
  name        = "sg1"
  description = "Allow all in and out"
  vpc_id      = aws_vpc.vpc1.id

  tags = {
    name = "dev"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_in_ipv4" {
  security_group_id = aws_security_group.sg1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_out_ipv4" {
  security_group_id = aws_security_group.sg1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_key_pair" "sshkey" {
	key_name = "sshkey"
	public_key = file("~/.ssh/linode.pub")
}

resource "aws_instance" "dev" {
	instance_type  = "t2.micro"
	ami = data.aws_ami.server_ami.id
	key_name = aws_key_pair.sshkey.id
	vpc_security_group_ids = [aws_security_group.sg1.id]
	subnet_id = aws_subnet.public_subnet.id

	root_block_device {
		volume_size = 10
	}

	tags = {
		name = "devnode"
	}

	user_data = file("userdata.tpl")
}
