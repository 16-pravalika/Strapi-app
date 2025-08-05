variable "aws_region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "image_tag" {}

variable "key_name" {
  default = "key-pair"
}
