resource "aws_instance" "web" {
  #count=11 # count.index is a special variable given by terraform
  #count=length(var.instance_names)
  for_each = var.instance_names
  ami           =data.aws_ami.centos8.id 
  #var.ami_id # devops-practice
  instance_type = each.value
  #var.instance_names[count.index]=="mongodb" || var.instance_names[count.index]=="mysql" || var.instance_names[count.index]=="shipping" ? "t3.small":"t2.micro" #var.instance_names=="Mongodb"?"t3.small":"t2.micro"
  tags={
   Name=each.key#var.instance_names[count.index]
  }
}

# resource "aws_route53_record" "www" {
#   #count=11
#   count=length(var.instance_names)
#   zone_id = var.zone_id
#   name    = "${var.instance_names[count.index]}.${var.domain_name}" #Interpolation
#   type    = "A"
#   ttl     = 1
#   records =[var.instance_names[count.index]=="web"?aws_instance.web[count.index].public_ip:aws_instance.web[count.index].private_ip]
# }

resource "aws_route53_record" "www" {
  #count=11
  #count=length(var.instance_names)
  for_each = aws_instance.web
  zone_id = var.zone_id
  name    = "${each.key}.${var.domain_name}"#"${var.instance_names[count.index]}.${var.domain_name}" #Interpolation
  type    = "A"
  ttl     = 1
  records =[startswith(each.key,"web")? each.value.public_ip : each.value.private_ip]
  #[each.key=="web"? each.value.public_ip : each.value.private_ip]
  #[var.instance_names[count.index]=="web"?aws_instance.web[count.index].public_ip:aws_instance.web[count.index].private_ip]

 }








# output "instances_info" {
#   value = aws_instance.web
# }