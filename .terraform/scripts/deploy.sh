$(which terraform) validate .terraform

$(which terraform) plan \
    -out=.terraform/contoso.tfplan \
    -var-file=.terraform/variables.tfvars \
    .terraform

$(which terraform) apply .terraform/contoso.tfplan
