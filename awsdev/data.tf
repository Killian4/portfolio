data "aws_ami" "server_ami" {

	most_recent = true
	owners = ["099720109477"]
	filter {
		name = "name"
		values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
	}

}
variable "ansible_username" {
	type=string
	default="ubuntu"
}

variable "username" {
	type = string
}

variable "password_hash" {
	type = string
}

variable "user_ssh_pubkey" {
	type = string
}

variable "ansible_ssh_file" {
	type = string
}

