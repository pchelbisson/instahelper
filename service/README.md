# Service: instahelper


## What's in the directory
- `cmd/server/` — Go service sources.
- `deploy.yml` — Ansible playbook for deploying the service.
- `.gitlab-ci.yml` — GitLab pipeline (build/test/deploy).
- `inventory.ini` — target host for deployment.

## How the pipeline works

Stages:

1. `build` — build the Docker image `pchelbisson/instahelper:$CI_COMMIT_REF_SLUG`.
2. `test` — run `go test ./...`.
3. `deploy` — run `ansible-playbook -i inventory.ini deploy.yml`.

### Launch conditions (current state)

- `build-job` and `test-job`: run in the regular pipeline (without a branch filter).
- `deploy-prod`: run only for the `master` branch.
- `deploy-uat`: run only for the `uat` branch.

## Manual deployment (local)
```bash
ansible-playbook -i inventory.ini deploy.yml -e "container_image=pchelbisson/instahelper:latest"
```

## Monitoring integration

The service exports metrics in Prometheus format on `/metrics`, and the monitoring stack from `infra/ansible/files/monitoring/` is configured to scrape the app on port `8080`.