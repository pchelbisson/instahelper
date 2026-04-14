# Infra

Infrastructure code for the `instahelper` environment: Terraform resources, host configuration, GitLab Runner setup, and monitoring rollout.

## Contents

- `envs/test/` — Terraform for the TEST environment.
- `envs/prod/` — Terraform for the PROD environment.
- `ansible/playbook.yml` — Docker, Runner, and monitoring configuration.
- `ansible/inventories/test/hosts.ini` — inventory for TEST.
- `ansible/inventories/prod/hosts.ini` — inventory for PROD.
- `ansible/files/monitoring/docker-compose.yml` — Prometheus + Grafana + Node Exporter.
- `ansible/files/monitoring/prometheus.yml` — scrape target configuration.

## What is automated

1. Separate creation of TEST and PROD infrastructure via Terraform.
2. Install Docker and Docker Compose on the host.
3. Install and register GitLab Runner.
4. Deploy monitoring stack in Docker Compose under `/opt/monitoring`.


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
