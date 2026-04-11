# Infra

Infrastructure code for the `instahelper` test environment and preparing the GitLab Runner.

## Compound

- `main.tf` — VM, target group, and network load balancer in Yandex Cloud.
- `variables.tf` / `providers.tf` / `outputs.tf` — input parameters and outputs.
- `ansible/playbook.yml` — Docker installation + GitLab Runner installation/registration.
- `ansible/inventory.ini` — configuration host.
- `ansible/credentials.yml` — vault file with Ansible secrets.

## What is already automated

1. Create a VM (preemptible) and LB via Terraform.
2. Prepare the Docker host via Ansible.
3. Install and register gitlab-runner via Ansible.


## Run

```bash
cd infra
terraform init
terraform apply
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```

