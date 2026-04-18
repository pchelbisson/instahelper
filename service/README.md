# Service: Instahelper (Educational Go Stub)

## Service Role in the Diploma Project

`instahelper` is intentionally a simple Go HTTP service used as a demonstrational workload for DevOps workflows:
- container build and packaging;
- automated test execution;
- deployment to TEST/PROD;
- metrics export for observability.

> Important: this is **not** a production business application; it is a training stub used to validate platform processes.

## Directory Contents

- `cmd/server/app.go` — HTTP app implementation (`/`, `/health`, `/metrics`).
- `cmd/server/app_test.go` — basic handler unit tests.
- `Dockerfile` — multi-stage container build.
- `deploy.yml` — Ansible playbook for service deployment.
- `templates/instahelper.service.j2` — systemd unit template for container run.
- `.gitlab-ci.yml` — CI/CD pipeline (build/test/deploy).

## Application Behavior

- `/health` — liveness endpoint (returns `ok`).
- `/metrics` — Prometheus metrics endpoint.
- `/` — plain text response with request debug details.

Application port: `8080`.

## CI/CD (GitLab)

Pipeline stages:
1. `build` — build Docker image.
2. `test` — run `go test ./...`.
3. `deploy_test` — deploy to TEST via Ansible inventory.
4. `deploy_prod` — deploy to PROD after TEST stage.

Current branch rules:
- TEST deploy: `master` and `uat`.
- PROD deploy: `master` only.

## Manual deployment (local)
```bash
# TEST
ansible-playbook -i ../infra/ansible/inventories/test/hosts.ini deploy.yml \
  -e "container_image=pchelbisson/instahelper:latest"

# PROD
ansible-playbook -i ../infra/ansible/inventories/prod/hosts.ini deploy.yml \
  -e "container_image=pchelbisson/instahelper:latest"
```

## Observability integration

The service exposes Prometheus-format metrics. These are scraped by the monitoring stack from `infra/ansible/files/monitoring/`, and container logs are collected through Promtail/Loki.