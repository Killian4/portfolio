# portfolio

## AWS DEV environment

This is a simply VM spun up through terraform, that uses ansible to configure it to run as a file sharing server. I created this because I wanted a server to share files, and terraform and ansible allows this resource to be prgrammatically created and destroyed at will.

### Terraform Setup
In order to authenticate to aws you will need to export the following variables
```bash
export AWS_ACCESS_KEY_ID="changeme"
export AWS_SECRET_ACCESS_KEY="changeme"
```

You will also need to create an ssh keypair and edit main.yml so that the key pair is referenced.

Run these terraform commands to spin up the virtual machine.

```bash
terraform init
terraform plan
terraform apply
```

### Ansible Configuration

Roles for the node can be specified in playbook.yml file. After applying terraform, an inventory file will be created for ansible to use. Run the following command in the ansible directory to configure the node. 
```bash
ansible-play -i inventory  playbook.yml

