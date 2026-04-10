# Infra

Infrastructure code for the `instahelper` testing environment.

## Implemented in Stage 1

This repository currently covers the **"Infrastructure for testing"** stage:

1. Terraform provisions core Yandex Cloud resources:
   - preemptible VM;
   - target group;
   - L4 network load balancer with public IPv4;
   - health check on `http://<target>:8080/`.
2. Ansible configures the VM for running Docker workloads:
   - installs Docker Engine;
   - installs Docker Compose binary;
   - adds `ubuntu` user to the `docker` group.

## Directory layout

- `providers.tf` — Yandex Cloud provider configuration.
- `variables.tf` — input variables (`yc_token`, `yc_cloud_id`, `yc_folder_id`, `yc_zone`, etc.).
- `main.tf` — compute instance, target group, and load balancer.
- `outputs.tf` — load balancer and VM public IP outputs.
- `ansible/playbook.yml` — host preparation for Docker service runtime.
- `ansible/inventory.ini` — static inventory (current stage).

## Requirements

- Terraform >= 1.3
- Ansible >= 2.12
- Yandex Cloud account with access to cloud/folder
- SSH public key at `~/.ssh/id_rsa.pub`

## Terraform variables

Create `infra/terraform.tfvars`:

```hcl
yc_token     = "<oauth_token>"
yc_cloud_id  = "<cloud_id>"
yc_folder_id = "<folder_id>"
yc_zone      = "ru-central1-a"
vm_name      = "instahelper-vm"
image_family = "ubuntu-2204-lts"
```

## Run Terraform

```bash
cd infra
terraform init
terraform fmt
terraform validate
terraform apply
```

Useful outputs:

- `load_balancer_ip`
- `vm_public_ip`

## Configure VM with Ansible

1. Update `ansible/inventory.ini` (`app` host IP) if needed.
2. Run:

```bash
cd infra/ansible
ansible-playbook -i inventory.ini playbook.yml
```

## Validation ideas

- Verify Docker:
  ```bash
  ssh ubuntu@<vm_public_ip> docker --version
  ```
- Verify load balancer endpoint after service deployment.

## Current limitations

- `main.tf` still has hardcoded `subnet_id` values.
- Domain DNS management through Terraform is not finished yet.
- Inventory is static and not auto-generated from Terraform outputs.

## Cleanup

```bash
cd infra
terraform destroy
```