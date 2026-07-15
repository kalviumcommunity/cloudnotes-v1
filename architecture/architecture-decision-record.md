# Architecture Decision Record (ADR)

## Decision 1

**Decision:** Use Cloud SQL (PostgreSQL) instead of SQLite.

**Context:** SQLite stores data in a single local file and cannot provide high availability, automatic backups, or replication.

**Alternatives:** Continue using SQLite on a Compute Engine VM.

**Trade-off:** Cloud SQL costs more than SQLite but provides automatic backups, patching, replication, and high availability.

---

## Decision 2

**Decision:** Deploy multiple Compute Engine VMs behind a Cloud Load Balancer.

**Context:** A single VM cannot handle high traffic or survive hardware failures.

**Alternatives:** Run the application on a single Compute Engine VM.

**Trade-off:** Multiple VMs increase infrastructure cost but improve scalability, availability, and fault tolerance.

---

## Decision 3

**Decision:** Store uploaded files and static assets in Cloud Storage.

**Context:** Files stored on a VM may be lost if the VM is deleted or fails.

**Alternatives:** Store uploads on the Compute Engine VM.

**Trade-off:** Cloud Storage adds storage costs but provides durable, scalable, and highly available object storage.

---

## Decision 4

**Decision:** Keep Compute Engine and Cloud SQL in private subnets protected by IAM and firewall rules.

**Context:** Backend resources should not be directly accessible from the internet.

**Alternatives:** Assign public IP addresses to application servers and databases.

**Trade-off:** Private networking requires additional configuration but significantly improves application security by reducing the attack surface.