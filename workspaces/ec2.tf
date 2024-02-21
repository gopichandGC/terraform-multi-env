resource "aws_instance" "web" {
  ami           = "ami-0f3c7d07486cad139"
  instance_type = lookup(var.instance_type,terraform.workspace)#"t2.micro"
  #vpc_security_group_ids=[aws_security_group.allow_tls.id] # This means list

  tags = {
    Name = "Hello-Terraform"
  }
}