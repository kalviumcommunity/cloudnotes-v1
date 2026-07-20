# Architecture Decision Records (ADR) - CloudNotes Migration

This document records the architectural decisions made for migrating the CloudNotes application from a local host to Google Cloud Platform (GCP).

---

## ADR-001: Database Migration from SQLite to Cloud SQL for PostgreSQL

### Decision
Migrate the relational database from a local file-bound SQLite database to a fully-managed **Cloud SQL for PostgreSQL** instance with High Availability (HA) enabled.

### Context
The current application stores all note metadata inside a single SQLite file (`database/cloudnotes.db`) located on the local disk. While lightweight, SQLite is tightly coupled to a single machine's local storage and enforces write-serialization (single writer lock). This prevents horizontal scaling of the compute tier (multiple app servers running concurrently) and introduces a single point of failure (SPOF) with no failover or backup automation.

### Alternatives
* **Keep SQLite on Compute Engine Persistent Disk:** Mount a shared persistent disk across VMs. *Reason for rejection:* Standard persistent disks cannot be mounted in write mode by multiple VMs simultaneously (ReadWriteMany limitation on block storage). Running SQLite in this manner is brittle and limits performance.
* **Self-hosted PostgreSQL on Compute Engine:** Spin up a separate VM running PostgreSQL. *Reason for rejection:* Requires manual database administration, backup configurations, patching, and complex manual setup for high availability failover.

### Trade-off
* **Pros:** Fully managed service (zero maintenance overhead), automatic multi-zone HA failover, automated point-in-time recovery backups, database encryption at rest and in transit, and support for high concurrent connection counts.
* **Cons:** Higher managed service cost compared to a zero-cost local SQLite file.

---

## ADR-002: Uploads Directory Migration to Google Cloud Storage (GCS)

### Decision
Migrate user-uploaded note attachments from the local host folder (`uploads/`) to a private **Google Cloud Storage (GCS)** regional bucket.

### Context
The Flask web application writes uploaded file attachments directly to the local directory `uploads/` and serves them from the local disk. In a distributed cloud environment, when traffic is load-balanced across multiple VM instances, files uploaded to VM-1 are not visible to VM-2. Furthermore, if instances are scale-down or auto-recreated, local files are destroyed. The compute layer must remain completely stateless to scale horizontally.

### Alternatives
* **Shared File System (Filestore / NFS):** Create a Google Cloud Filestore instance and mount it via NFS as `/uploads` on all VMs. *Reason for rejection:* High basic cost and complex mounting configurations compared to Cloud Storage, which is built natively for web-scale object access.
* **Local disk sync scripts:** Run a background process (like `rsync` or `csync`) to replicate files across VMs. *Reason for rejection:* Unreliable, high synchronization lag, high local disk I/O load, and does not support dynamic instance scaling.

### Trade-off
* **Pros:** Highly scalable and durable object storage (`99.999999999%` durability), stateless application servers, global accessibility, and fine-grained access control using IAM bucket policies.
* **Cons:** Requires a minor application code change to replace python's `shutil` / `os` operations with the Google Cloud Storage SDK client libraries.

---

## ADR-003: Compute Platform Selection - Compute Engine Managed Instance Groups

### Decision
Host the Flask web application using **Google Compute Engine (GCE) Managed Instance Groups (MIG)** running inside a private subnet of a custom VPC network.

### Context
We need a robust, enterprise-grade compute platform that can run the Flask server, scale automatically based on resource consumption (CPU/memory), heal itself if a server crashes, and protect the application from direct external network attacks.

### Alternatives
* **Google Cloud Run (Serverless):** Build the Flask application as a container and host it serverless. *Reason for rejection:* While Cloud Run is excellent, GCE MIG was selected to demonstrate a traditional multi-tier enterprise network design with explicit private subnets, bastion host administration, custom OS machine images (VMs), and traditional VPC firewall controls.
* **Google Kubernetes Engine (GKE):** Orchestrate the application container inside a Kubernetes cluster. *Reason for rejection:* Introduces significant administrative complexity and cost overhead that is disproportionate to the requirements of a simple monolithic Flask application.

### Trade-off
* **Pros:** VM-level control for OS hardening, automatic instance healing, compatibility with traditional network security designs, and native auto-scaling.
* **Cons:** Higher administrative management compared to serverless container systems (requires setting up instance templates and VM startup scripts).
