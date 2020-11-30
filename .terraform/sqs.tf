resource "aws_sqs_queue" "worker-queue" {
  tags = {
    "Terraform"   = "true"
    "Environment" = "dev"
  }
}
