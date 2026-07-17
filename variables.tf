variable "cidr_block" {
    description = "Please provide CIDR block for VPC"
    type = string
    default = ""
}

variable "region" {
    description = "Please provide a region"
    type = string
    default = ""
}

variable "public_subnet1" {
    description = "Please provide public subnet1"
    type = string
    default = ""
}

variable "public_subnet2" {
    description = "Please provide public subnet2"
    type = string
    default = ""
}

variable "public_subnet3" {
    description = "Please provide public subnet2"
    type = string
    default = ""
}


# variable "private_subnet1" {
#     description = "Please provide private subnet1"
#     type = string
#     default = ""
# }

# variable "private_subnet2" {
#     description = "Please provide private subnet1"
#     type = string
#     default = ""
# }

# variable "private_subnet3" {
#     description = "Please provide private subnet1"
#     type = string
#     default = ""
# }


variable name_prefix {
    description = "Please provide a value"
    type = string
    default = ""
}

variable image_id {
    description = "Please provide an image id"
    type = string
    default = ""
}

variable instance_type {
    description = "Please provide an instance type"
    type = string
    default = ""
}

variable desired_capacity {
    description = "Please provide a value"
    type = string
    default = ""
}

variable max_size {
    description = "Please provide a value"
    type = string
    default = ""
}

variable min_size {
    description = "Please provide a value"
    type = string
    default = ""
}

variable subnets {
  type = list
  description = "Please provide a value"
  default = []
}

variable availability_zones {
    description = "Please provide a value"
    type = string
    default = ""
}

variable "allowed_ssh_cidr" {
  type    = string
  default = ""
}

