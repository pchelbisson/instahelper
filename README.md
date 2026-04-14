# Instahelper — service, infrastructure, CI/CD, and monitoring

The repository contains the `instahelper` service, infrastructure in Yandex Cloud and automation of delivery to **TEST** and **PROD** environments.

## Structure

- `service/` — Go service, tests, and deployment playbook.
- `infra/` — Terraform + Ansible for `test` and `prod` environments, plus monitoring.

## What is implemented

- The infrastructure is divided into two environments:
- `infra/envs/test` — test infrastructure;
- `infra/envs/prod` — production infrastructure.
- Ansible inventory is divided into environments:
- `infra/ansible/inventories/test/hosts.ini`
- `infra/ansible/inventories/prod/hosts.ini`
- CI/CD in `service/.gitlab-ci.yml`:
- build and tests first,
- then deploy to TEST,
- then deploy to PROD (from `master` only),
- the same Docker image is used for TEST and PROD.
- Monitoring (Prometheus + Grafana + Node Exporter) is enabled via Ansible and covers both environments.

More details are in `infra/README.md` and `service/README.md`.

## Quick start

```bash
# 1) Start the TEST infrastructure
cd infra/envs/test
terraform init
terraform apply

# 2) Start the PROD infrastructure
cd ../prod
terraform init
terraform apply

# 3) Configure hosts and monitoring
cd ../../ansible
ansible-playbook -i inventories/test/hosts.ini playbook.yml
ansible-playbook -i inventories/prod/hosts.ini playbook.yml

# 3) Service CI/CD details
cd ../../service
# see .gitlab-ci.yml and service/README.md
```

## Monitoring

The monitoring stack is located in `infra/ansible/files/monitoring/` and deployed to `infra/ansible/playbook.yml`.
