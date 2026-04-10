# Infrastructure Platform — Final Project

## About the Project

This is my final project for the "DevOps Engineer: Fundamentals" course.
I'm building an infrastructure platform similar to those used in real companies. The project demonstrates my approach to automation, environment organization, and cloud computing.

## What's Inside

The repository has two main sections:

- `infra/` — all infrastructure as code: Terraform, Ansible, environment setup, and auxiliary services.
- `service/` — an example microservice that shows developers how to use the platform.

## How I work with the cloud (Yandex Cloud)

I use Yandex Cloud with a free grant of 4,000 rubles. To stay within the limits:

- I only deploy the infrastructure for the duration of the work;
- I use preemptible VMs (they're significantly cheaper);
- I destroy everything ('terraform destroy') after each session;
- I monitor disks, snapshots, reserved IPs, and load balancers;
- I only deploy the full platform at the end for a final check.

DNS: If possible, I'll link a domain (or find a free alternative) and manage records through Terraform.

## What I use

- Terraform — for creating cloud resources
- Ansible — for server configuration
- Ansible Galaxy — pre-built roles where appropriate
- Terraform Registry — pre-built modules

## How to run everything on your own

```bash
git clone <my repository>
cd infra/terraform
terraform init
terraform apply
```

After applying terraform:

```bash
cd ../ansible
ansible-playbook playbook.yml
```
To run the example service:

```bash
cd ../../service
```
# continue with the README inside service/
To delete everything:

```bash
cd infra/terraform
terraform destroy
```