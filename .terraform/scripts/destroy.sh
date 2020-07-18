cd .terraform

$(which terraform) destroy \
    -var-file=/variables.tfvars
