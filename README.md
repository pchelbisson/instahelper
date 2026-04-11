# Instahelper — infrastructure and CI/CD

This repository contains the `instahelper` service and the infrastructure code to deploy and run it via GitLab CI.

## Structure

- `infra/` — Terraform + Ansible for VM and GitLab Runner.
- `service/` — Go service, Ansible deployment, and `.gitlab-ci.yml`.

## What has already been implemented

- Terraform deploys a VM + target group + L4 LB in Yandex Cloud.
- Ansible installs Docker and GitLab Runner on the host.
- The following stages are configured in service/.gitlab-ci.yml: build, test, and deploy.
- A separate deploy job (deploy-uat) is configured for uat.

More details are in `infra/README.md` and `service/README.md`.

## Quick start

```bash
# Infra
cd infra
terraform init
terraform apply
# Runner + Docker
cd ansible
ansible-playbook -i inventory.ini playbook.yml
# Service CI/CD is described in service/.gitlab-ci.yml
```
