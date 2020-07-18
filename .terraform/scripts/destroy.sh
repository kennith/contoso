$(which terraform) destroy \
    -var-file=.terraform/variables.tfvars \
    .terraform
