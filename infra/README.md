# Infra

This section contains all platform-level automation: resource provisioning, server configuration, CI runner setup, and observability deployment.

## Contents

- `envs/test/` — Terraform for the TEST environment.
- `envs/prod/` — Terraform for the PROD environment.
- `ansible/playbook.yml` — host bootstrap and platform service automation.
- `ansible/inventories/test/hosts.ini` — TEST inventory.
- `ansible/inventories/prod/hosts.ini` — PROD inventory.
- `ansible/files/monitoring/docker-compose.yml` — monitoring stack (Prometheus, Grafana, Node Exporter).
- `ansible/files/monitoring/prometheus.yml` — scrape targets and config.

## What is automated

1. **Separate TEST/PROD provisioning** via Terraform.
2. **Host preparation**: Docker/Compose and base dependencies.
3. **GitLab Runner installation and registration** (Docker executor).
4. **Monitoring rollout** under `/opt/monitoring` via Docker Compose.
5. **Logging integration** (Promtail + Grafana Cloud Loki) through an Ansible role.

## Architecture Principles

- Isolated environments with dedicated inventory files.
- Reproducible operations through IaC and Ansible automation.
- Observability included in the default platform baseline.
- Lightweight stack choices suitable for resource-constrained hosts.


## Run

```bash
# TEST
cd infra/envs/test
terraform init
terraform apply
# PROD
cd ../prod
terraform init
terraform apply

# Host configuration
cd ../../ansible
ansible-playbook -i inventories/test/hosts.ini playbook.yml
ansible-playbook -i inventories/prod/hosts.ini playbook.yml
```

## Monitoring endpoints

After a successful Ansible run, the following services should be available:

- `http://<host>:9090` — Prometheus
- `http://<host>:3000` — Grafana
- `http://<host>:9100/metrics` — Node Exporter metrics

Prometheus scrapes:

- itself (`localhost:9090`)
- node exporter (`node-exporter:9100`)
- `instahelper` app metrics (`172.17.0.1:8080`)
