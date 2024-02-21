variable "instance_names" {
    type=map
    # default={
    # mongodb = "t3.small"
    # redis = "t2.micro"
    # rabbitmq = "t2.micro"
    # }
  
}
variable "zone_id"{
default="Z01392352BS5MX7GMAHS1"
}

variable "domain_name" {
    default="techwithgopi.online"
}