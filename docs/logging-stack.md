# Choosing a log management system for Instahelper

## Status: Accepted

## Context:

- Need to collect logs from Docker containers for debugging business logic.

- Resource constraints: VMs have only **2 GB RAM**, which precludes running heavy Java applications (Elasticsearch).

- Need a fast and free solution for the MVP stage.

- The monitoring stack already uses Grafana.

## Solution:

Use a hybrid solution: **Promtail** (host-based agent) + **Grafana Cloud Loki** (cloud backend).

- **Promtail**: A lightweight agent deployed via Docker Compose collects logs from `/var/lib/docker/containers`.

- **Loki**: Cloud storage in Grafana Cloud (Free Tier).

## Consequences:

- **Pros**:

- **Zero-cost**: Uses 50 GB of free storage.

- **Performance**: RAM load is minimal (unlike ELK).

- **UX**: Logs and metrics are available in a single Grafana interface.

- **Security**: Secrets (API Keys) are stored in **Ansible Vault**.

- **Cons**:

- Dependence on an external provider and internet connection.

- Storage limit in the free plan (14 days).

## Migration Strategy (Next Steps):

If the load and data volumes grow beyond 50 GB/month, we plan to migrate to **Managed Service for OpenSearch** in Yandex Cloud to ensure fault tolerance and long-term storage.