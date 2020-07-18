# CHANGELOG

Not really a changelog at the moment.

## On infrastructure

It's very easy to use Terraform module to build a VPC. However, I am thinking if I am right to put the app and infrastructure into the same repository. 

In the beginning, I wanted to have an app, run as web, worker, and queue worker, at the same time, it has the scripts necessary to build the infrastruture to place the app in the cloud. Now I am leaning towards separating the app and infrastructure code. Let the infrastructure code to tell the app where to place itself into. 

The layout currently have the app as the main character, the infrastructure is the supporting cast (since I put it in `.terraform`). 

I guess if I am building an infrastructure for many app, then separating it from the app makes sense. If I want the app to be "self contain", then including the infrastructure code maybe OK.

## On scripts

The scripts are to automate the repeating tasks. In the scripts for Terraform, I placed them in the `.terraform/scripts` folder. I am thinking if I should put them in `scripts` instead. The cons is it will "poplute" the app (Laravel) existing strcture, which is why I thought separating the infrastructure code and app code may make sense.
