# A web application

data "aws_ami" "web" {
  most_recent = true

  # change this to image built with packer
  name_regex = var.web_ami_regex
  owners     = ["099720109477"]

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "deploy" {
  key_name   = "deployer-key"
  public_key = var.deploy_key
}

module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["10.10.0.0/16"]
}

module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "web-cluster"
  instance_count = 5

  ami                    = data.aws_ami.web.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deploy.key_name
  vpc_security_group_ids = [module.web_server_sg.this_security_group_id]
  subnet_id              = element(module.vpc.private_subnets, 0)

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
