variable "region" {
  default = "us-east-2"
}

variable "ami" {
  description = "Amazon Machine Image ID"
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 for us-east-2
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}
 
variable "key_name" {
  default     = "key"
  description = "Name of the EC2 key pair"
}

variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
  sensitive   = true
}

variable "dockerhub_password" {
  description = "Docker Hub password"
  type        = string
  sensitive   = true
}

variable "docker_image" {
  description = "Docker image to run"
  default     = "strapi:latest"
}

