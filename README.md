# Contoso

a full stack (frontend, backend, infrastructure) experiment. 

## Infrastructure

- The AWS infrastructure is built and continuously updated using Terraform.
- The application deployment is delivered through GitHub action and Packer.

## App

- The application built using Laravel framework. 

## Overview

Build front-end, back-end, and infrastructure all in a single code repository.

- a web interface
- a queue worker to process job from queue
- a schedule worker to process job

### AWS

- A VPC
- A private subnet for queue and schedule workers.
- A public subnet for web.
- A database for data storage.
- A queue.

### Web interface

The application serves behind a load balancer. It scales up or down depending on the web traffic. 

### Queue worker

The queue workers scales up or down depending on the size of the queue.

### Process worker

The process worker scales up or down depending on the job schedules. A complicated schedule job should move to queue worker. 