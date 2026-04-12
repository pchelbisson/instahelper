# Infra

Infrastructure code for the `instahelper` environment: Terraform resources, host configuration, GitLab Runner setup, and monitoring rollout.

## Contents

- `main.tf` — VM, target group, and network load balancer in Yandex Cloud.
- `variables.tf` / `providers.tf` / `outputs.tf` — inputs and outputs.
- `ansible/playbook.yml` — Docker + GitLab Runner + monitoring deployment.
- `ansible/inventory.ini` — target host inventory.
- `ansible/credentials.yml` — vault file with Ansible secrets.
- `ansible/files/monitoring/docker-compose.yml` — Prometheus/Node Exporter/Grafana stack.
- `ansible/files/monitoring/prometheus.yml` — scrape configuration.
- `ansible/docs/ladr/monitoring-stack.md` — architecture decision for monitoring stack.

## What is automated

1. Provision a preemptible VM and load balancer via Terraform.
2. Install Docker and Docker Compose on the host.
3. Install and register GitLab Runner.
4. Deploy monitoring stack in Docker Compose under `/opt/monitoring`.


## Run

```bash
cd infra
terraform init
terraform apply
cd ansible
ansible-playbook -i inventory.ini playbook.yml
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
