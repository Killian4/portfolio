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
		[server]
		${aws_instance.dev.public_ip}
		[server:vars]
		ansible_user=${var.username}
		ansible_become=True
		ansible_become_method="sudo"
		DOC
	file_permission="0640"
	filename="./ansible/inventory"
		
}
