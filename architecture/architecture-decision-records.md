# CloudNotes Architecture Decision Record

## ADR-01 — Database
**Decision:** Use Cloud SQL for PostgreSQL.  
**Context:** SQLite is a local file tied to one machine.  
**Alternatives:** SQLite on VM; self-managed PostgreSQL; Cloud SQL.  
**Trade-off:** More managed-service cost in exchange for shared persistence, backups and HA.

## ADR-02 — Compute
**Decision:** Use Compute Engine Managed Instance Group behind an HTTPS Load Balancer.  
**Context:** Flask can migrate to VMs with limited changes; one VM cannot reliably handle 10× traffic.  
**Alternatives:** Single VM; Cloud Run; GKE.  
**Trade-off:** More VM management, but a direct migration path and clear network control.

## ADR-03 — Files
**Decision:** Use Cloud Storage for uploads and static files.  
**Context:** VM-local files are not shared across application instances.  
**Alternatives:** Local disk; shared filesystem; Cloud Storage.  
**Trade-off:** Requires object-storage integration but provides durable shared files.

## ADR-04 — Security
**Decision:** Only the HTTPS Load Balancer is publicly accessible; application and database resources remain private.  
**Context:** Public VMs or databases increase the attack surface.  
**Alternatives:** Public application/database endpoints.  
**Trade-off:** More VPC and firewall configuration for stronger isolation.
