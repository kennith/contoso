cd .terraform

$(which terraform) validate

$(which terraform) plan \
    -out=contoso.tfplan \
    -var-file=variables.tfvars \
