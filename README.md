# Instahelper — service, infrastructure, CI/CD, and monitoring

This repository contains the `instahelper` service, infrastructure code for Yandex Cloud deployment, and automation for both delivery and monitoring.

## Structure

- `service/` — Go service, tests, and deployment playbook.
- `infra/` — Terraform + Ansible for infrastructure, GitLab Runner setup, and monitoring stack rollout.

## What is implemented

- Terraform deploys a VM, target group, and L4 load balancer in Yandex Cloud.
- Ansible installs Docker and GitLab Runner on the target host.
- CI/CD pipeline is configured in `service/.gitlab-ci.yml` (build, test, deploy).
- Separate deploy jobs exist for `master` (prod) and `uat` branches.
- Monitoring stack is deployed automatically via Ansible:
  - Prometheus (`:9090`)
  - Node Exporter (`:9100`)
  - Grafana (`:3000`)

More details are in `infra/README.md` and `service/README.md`.

## Quick start

```bash
# 1) Provision infrastructure
cd infra
terraform init
terraform apply

# 2) Configure host, runner, and monitoring
cd ansible
ansible-playbook -i inventory.ini playbook.yml

# 3) Service CI/CD details
cd ../../service
# see .gitlab-ci.yml and service/README.md
```

## Monitoring

The monitoring stack is managed in `infra/ansible/files/monitoring/` and launched by the main Ansible playbook.

After provisioning, verify endpoints:

- `http://<host>:9090` — Prometheus
- `http://<host>:3000` — Grafana
- `http://<host>:9100/metrics` — Node Exporter metrics
