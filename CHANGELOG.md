# CHANGELOG

Not really a changelog at the moment.

## On infrastructure

It's very easy to use Terraform module to build a VPC. However, I am thinking if I am right to put the app and infrastructure into the same repository.

In the beginning, I wanted to have an app, run as web, worker, and queue worker, at the same time, it has the scripts necessary to build the infrastruture to place the app in the cloud. Now I am leaning towards separating the app and infrastructure code. Let the infrastructure code to tell the app where to place itself into.

The layout currently have the app as the main character, the infrastructure is the supporting cast (since I put it in `.terraform`).

I guess if I am building an infrastructure for many app, then separating it from the app makes sense. If I want the app to be "self contain", then including the infrastructure code maybe OK.

## On scripts

The scripts are to automate the repeating tasks. In the scripts for Terraform, I placed them in the `.terraform/scripts` folder. I am thinking if I should put them in `scripts` instead. The cons is it will "poplute" the app (Laravel) existing strcture, which is why I thought separating the infrastructure code and app code may make sense.

## Conclusion

I have built all the components needed for this project. Here is what I learn.

1. It's nice to start using Terraform from version 0.12.
2. Terraform Cloud is a good tool to use for production. Forget about s3-ing the state file.
3. Having a hands-on knowledge with AWS (or the cloud service provider) before using Terraform to ease the development. There is no shortcut and Terraform is not a magic wand.
4. Using Terraform module is like using a framework on a language. It removes a lot of repeating work and avoiding common mistakes.
5. Make sure the [.gitignore](https://github.com/github/gitignore/blob/master/Terraform.gitignore) for Terraform is setup correctly before coding.

This concludes my experiment with Terraform with a Laravel app. It is best to keep the infrastructure code from the application code. Therefore, the structure of this repository is not good. I will separate them into two by moving .terraform folder to another repository.

e.g.

```
- contoso-infrastructure
- contoso
```

On a note with Terraform cloud, [build a workspace for each environment](https://www.terraform.io/docs/cloud/guides/recommended-practices/part1.html). This will absolutely making the workflow a lot easier.
