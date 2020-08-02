module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "contoso"
  cidr = "172.18.0.0/16"

  database_subnet_assign_ipv6_address_on_creation = false

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["172.18.1.0/24", "172.18.2.0/24", "172.18.3.0/24"]
  public_subnets  = ["172.18.101.0/24", "172.18.102.0/24", "172.18.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
