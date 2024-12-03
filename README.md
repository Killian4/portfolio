# portfolio

## AWS DEV environment

This is a simple VM spun up through terraform, that uses ansible to configure it to run as a file sharing server. I created this because I wanted a server to share files, and terraform and ansible allows this resource to be prgrammatically created and destroyed at will.
### Requirements

You will need [terraform](https://developer.hashicorp.com/terraform/install) and [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed to use this.
### Terraform with AWS provider Setup
In order to authenticate to aws you will need to export the following variables. Docs on creating an AWS Secret and Access keys are found [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)

```bash
export AWS_ACCESS_KEY_ID="changeme"
export AWS_SECRET_ACCESS_KEY="changeme"
```

You will also need to create an ssh keypair and edit main.yml so that the key pair is referenced.

You will also want to edit the .env file and set the variables accordingly

Run these terraform commands to spin up the virtual machine.

```bash
terraform init
terraform plan
terraform apply
```

### Ansible Configuration

Roles for the node can be specified in playbook.yml file. After applying terraform, an inventory file will be created for ansible to use. Run the following command in the ansible directory to configure the node. 

```bash
cd ansible/
ansible-play -i inventory  playbook.yml
```
