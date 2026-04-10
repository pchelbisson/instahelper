# Service Deployment Template

This Ansible playbook deploys a Docker container as a system service (systemd).

## Requirements
1. Docker must be installed on the target host.
2. The playbook directory must contain a `templates/` folder with the `instahelper.service.j2` file.

## How to use

1. Make sure the `app` host is defined in your inventory file.
2. In the `deploy.yml` file or using the `-e` switches, configure the following variables:
* `service_name`: service name (e.g., `my-app`).
* `container_image`: Docker image name (e.g., `pchelbisson/instahelper:latest`).
* `container_port`: port forwarding (e.g., `8080:8080`).

3. Run the playbook:
```bash
ansible-playbook -i inventory.ini deploy.yml
```
