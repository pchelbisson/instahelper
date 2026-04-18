# Instahelper — DevOps Diploma Project (Infrastructure Platform)

> This repository is a **DevOps diploma project**.  
> The primary value is the end-to-end infrastructure lifecycle (IaC, CI/CD, observability, operations), not application business logic.

## Project Overview

`instahelper` demonstrates how to build and operate a small infrastructure platform with separate `TEST` and `PROD` environments and automated delivery.

The service in `service/` is a **Go-based educational stub website** (simple HTTP app with `/health` and `/metrics`) used as a deployment and monitoring target.

## Diploma Goal

Show practical DevOps capabilities on a complete hands-on setup:
- infrastructure design as code;
- automated host and service configuration;
- CI/CD pipeline with controlled promotion across environments;
- observability (metrics + logs);
- operational readiness and secrets handling.

More details are in `infra/README.md` and `service/README.md`.

## Technology Stack

### Core runtime
- **Go** — educational HTTP service (stub app).
- **Docker** — application and observability component containerization.
- **Docker Compose** — monitoring/logging stack deployment on hosts.

### IaC and configuration management
- **Terraform** — infrastructure provisioning in Yandex Cloud (separate TEST/PROD).
- **Ansible** — host bootstrap, service deployment, Runner setup, monitoring/logging rollout.
- **Ansible Vault** — secure storage of sensitive values (tokens/keys).

### CI/CD
- **GitLab CI/CD** — pipeline stages: `build → test → deploy_test → deploy_prod`.
- **GitLab Runner (Docker executor)** — pipeline job execution on prepared hosts.

### Observability
- **Prometheus** — metrics collection.
- **Node Exporter** — host-level metrics.
- **Grafana** — dashboards and visualization.
- **Promtail + Grafana Cloud Loki** — container log shipping and storage.

## Architecture Decisions

- **Environment isolation**: independent Terraform configs and Ansible inventory for `test` and `prod`.
- **Single delivery artifact**: one container image is promoted through environments.
- **Progressive rollout**: deployment flows through `TEST` before `PROD`.
- **Observability-by-default**: monitoring and logging are provisioned by infrastructure code.
- **Deliberately simple workload**: the app is minimal so platform engineering quality is the focus.

## Tools and Engineering Practices

- IaC for reproducible environment provisioning.
- Configuration management for consistent host setup.
- CI/CD automation (build, test, controlled deployment).
- Baseline operations: health checks, metrics endpoint, centralized logs.
- ADR-style documentation for key choices:
  - `docs/monitoring-stack.md`
  - `docs/logging-stack.md`

## Repository Structure

- `service/` — Go stub app, Dockerfile, deployment playbook, CI config.
- `infra/` — Terraform + Ansible for environments and platform services.
- `docs/` — architecture/decision notes (monitoring, logging).
- `screenshots/` — pipeline and observability screenshots.

## Quick Start

```bash
# 1) Provision the TEST infrastructure
cd infra/envs/test
terraform init
terraform apply

# 2) Provision the PROD infrastructure
cd ../prod
terraform init
terraform apply

# 3) Configure hosts and platform services (monitoring/logging/runner)
cd ../../ansible
ansible-playbook -i inventories/test/hosts.ini playbook.yml
ansible-playbook -i inventories/prod/hosts.ini playbook.yml

# 4) Review CI/CD and service deployment details
cd ../../service
# see service/.gitlab-ci.yml and service/README.md
```

## Why this should matter

This is not a commercial product domain demo — it is an infrastructure engineering demo that shows:
- ability to assemble and automate a full delivery platform;
- understanding of release flow and environment promotion;
- practical observability integration around a running service;
- engineering communication through structured technical documentation.

See subsystem details in `infra/README.md` and `service/README.md`.
