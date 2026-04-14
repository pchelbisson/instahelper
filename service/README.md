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
3. `deploy_test` — deployment to the TEST environment via `../infra/ansible/inventories/test/hosts.ini`.
4. `deploy_prod` — deployment to the PROD environment via `../infra/ansible/inventories/prod/hosts.ini`.

### Launch conditions (current state)

- `build-job` and `test-job`: run in the regular pipeline (without a branch filter).
- `deploy-test` is run for the `master` and `uat` branches.
- `deploy-prod` is run only for the `master` branch.
- The production deployment occurs after the test deployment, since the `deploy_prod` stage is located after `deploy_test`.
- The same image is used for TEST and PROD: `pchelbisson/instahelper:latest`.

## Manual deployment (local)
```bash
# TEST
ansible-playbook -i ../infra/ansible/inventories/test/hosts.ini deploy.yml -e "container_image=pchelbisson/instahelper:latest"

# PROD
ansible-playbook -i ../infra/ansible/inventories/prod/hosts.ini deploy.yml -e "container_image=pchelbisson/instahelper:latest"
```

## Monitoring integration

The service exports metrics in Prometheus format on `/metrics`, and the monitoring stack from `infra/ansible/files/monitoring/` is configured to scrape the app on port `8080`.