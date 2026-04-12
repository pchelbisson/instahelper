# Choosing a Monitoring Stack for Instahelper

## Status: Accepted
## Context:
- Release in a week, need visibility into service and server status.
- The application outputs metrics in Prometheus format.
- Automation via Terraform and Ansible is required.

## Solution:
Use Prometheus + Node Exporter + Grafana.

Deployment: Docker Compose on the existing application host.

## Cons:
- Pros: Native support for Go application metrics, powerful visualization, fast automation.
- Cons: Requires data retention configuration and UI access restrictions.
