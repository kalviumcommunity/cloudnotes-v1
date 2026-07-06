# Architecture Decision Record (ADR)

## Decision 1

**Decision:** Use Cloud SQL instead of SQLite.

**Context:** SQLite stores all data in a single local database file, which limits scalability and high availability.

**Alternative:** Host PostgreSQL on a Compute Engine VM.

**Trade-off:** Cloud SQL has a higher cost but provides automatic backups, failover, and managed maintenance.

---

## Decision 2

**Decision:** Place only the Load Balancer in the public network.

**Context:** Reducing the number of publicly accessible resources improves security.

**Alternative:** Expose Compute Engine instances directly to the internet.

**Trade-off:** Using a Load Balancer adds networking complexity but significantly reduces the attack surface.

---

## Decision 3

**Decision:** Store uploaded files in Cloud Storage.

**Context:** Files stored on a VM can be lost if the VM fails.

**Alternative:** Store uploaded files on the Compute Engine local disk.

**Trade-off:** Cloud Storage incurs additional cost but provides high durability, scalability, and easier management.