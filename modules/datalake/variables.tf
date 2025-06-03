variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "security_groups_id_ec2" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}