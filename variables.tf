variable "count_numbers" {
  type = number
  default = 1
}

variable "ami" {
  description = "AMI Id by AWS region"
  type        = string
  default     = "ami-08355844f8bc94f55"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "region" {
    description = "Region"
    type = string
    default = "ca-central-1"

}

variable "vpc_cidr" {
    description = "VPC cidr range"
    type = string
    default = "10.0.0.0/16"
}

variable "availability_zone" {
    description = "Availability Zones"
    type = list(string)
    default     = ["ca-central-1a", "ca-central-1b"]
}

variable "public_subnets" {
    description = "public subnets descriptions"
    type = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

