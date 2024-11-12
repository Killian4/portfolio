resource "local_file" "tf_ansible_vars" {
	content = <<-DOC
		tf_public_ip: ${aws_instance.dev.public_ip}
		tf_username: ${var.username}
		tf_passwd: ${var.passwd}
		DOC
	file_permission="0640"
	filename="./ansible/ansible_vars.yml"
}

resource "local_file" "tf_inventory" {
	content = <<-DOC
		[ftp]
		${aws_instance.dev.public_ip}
		[ftp:vars]
		ansible_user=${var.username}
		ansible_password=${var.passwd}
		ansible_become=True
		ansible_become_method="sudo"
		ansible_become_password=${var.passwd}
		DOC
	file_permission="0640"
	filename="./ansible/inventory"
		
}
