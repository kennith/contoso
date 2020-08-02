variable "region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "deploy_key" {
  type = string
}

variable "web_ami_regex" {
  type    = string
  default = "^ubuntu/images/hvm-ssd/ubuntu-focal-20.04-*"
}
