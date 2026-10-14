# CloudNotes Evidence Index

## 1. Review Metadata

- **Assessment date:** 2026-10-14
- **Repository:** `cloudnotes-v1`
- **Assessment branch:** `assessment/production-readiness-clean`
- **Previous assessment snapshot commit:** `8ce6ab0c3d8b897428328128f1ed98ac2c1eec75`
- **Evidence capture source revision:** `3837a0cbecc5ce740cc36309aafe6d49547d9e94`
- **Previously identified application source revision:** `83da3cd68f6414350ba79f53f8b85ecce41b13de` (relationship to the captured runtime image not verified)
- **Environment:** Local development environment using Minikube and Kubernetes
- **Deployment image observed:** `localhost:5000/cloudnotes:1.0.1`
- **Image-to-source mapping:** Not verified
- **Working-tree state at evidence capture:** Uncommitted application and infrastructure changes were present
- **Production environment:** Not assessed
- **Target SLO, RTO and RPO:** Not defined or evidenced; these must be agreed with the service owner
- **Current assessment commit:** Refer to the current PR head SHA in the PR description; update it after every assessment commit.
- **Evidence policy:** Evidence must be traceable to an artifact or accessible URL. Configuration demonstrates that a control is defined, not necessarily that it works. Missing proof remains UNVERIFIED.

## 2. Evidence Register

See [`missing-evidence-register.md`](missing-evidence-register.md) for the control-by-control evidence gaps, required closure tests, unresolved ownership, and target-date limitations.

### E01 — Application Tests and Deployment Source

- **Evidence artifacts:** `production-readiness/evidence/local-baseline.txt`; source files `app.py` and `k8s/deployment.yaml`
- **Type:** Automated test output and application/deployment source
- **Capture date:** 2026-10-14
- **Environment:** Local development environment
- **Git revision at capture:** `3837a0cbecc5ce740cc36309aafe6d49547d9e94`
- **Expected result:** The available automated tests complete successfully, and the application/deployment configuration can be inspected.
- **Observed result:** The captured test run using `./venv/bin/pytest -q` reported 2 passed tests and 1 Flask deprecation warning concerning `before_first_request`.
- **Checks potentially supported:** R3 and limited aspects of R4; O3 only when the relevant log output supports the specific claim.
- **Limitations:** The two tests cover the home and notes routes with database initialization mocked. They do not establish database integration, production behavior, resilience, security, or performance. Uncommitted changes were present during capture, so the test result must not be attributed exclusively to the committed source revision.

### E02 — Container and Local Environment

- **Candidate sources:** `Dockerfile`, `docker-compose.yml`, `Makefile`
- **Type:** Build and environment configuration
- **Capture date and source revision:** Not verified
- **Expected result:** The documented local environment can be built and run reproducibly.
- **Observed result:** No verified build or reproducibility result is included in the current evidence set.
- **Checks potentially supported:** R3 and R4, if successful build and run evidence is collected.
- **Limitations:** The existence of build and environment files does not prove a successful build, reproducible environment, or reliable deployment.
- **Next action:** Capture the relevant build/run commands and their actual output, including the tested revision.

### E03 — Kubernetes Configuration and Workload State

- **Evidence artifact:** `production-readiness/evidence/runtime-configuration.txt`
- **Candidate source files:** `k8s/configmap.yaml`, `k8s/deployment-good.yaml`, `k8s/ingress.yaml`, `k8s/network-policy.yaml`, `k8s/pvc.yaml`, and the active deployment configuration
- **Type:** Kubernetes runtime and configuration capture
- **Capture date:** 2026-10-14
- **Environment:** Local Minikube/Kubernetes cluster
- **Git revision at capture:** `3837a0cbecc5ce740cc36309aafe6d49547d9e94`; the running image's source mapping is unverified
- **Expected result:** The workload, services, networking, storage and configuration can be inspected and their observed state recorded.
- **Observed result:** The captured output showed three CloudNotes pods and one PostgreSQL pod Ready. The CloudNotes deployment used image `localhost:5000/cloudnotes:1.0.1`, defined liveness and readiness probes, configured CPU/memory requests and limits, and referenced a Kubernetes Secret for the database URL. A PostgreSQL NetworkPolicy was configured.
- **Checks potentially supported:** R3; limited aspects of R4; S4 for the existence of a NetworkPolicy; D1 only if the relevant storage configuration is directly inspected.
- **Limitations:** A ready pod does not establish sustained availability or successful recovery. A configured NetworkPolicy does not prove that the cluster enforces it. The existence of a persistent volume claim or manifest does not prove successful backup or restore.

### E04 — Monitoring Configuration

- **Candidate sources:** `prometheus.yml`, `promtail.yml`
- **Type:** Monitoring and logging configuration
- **Capture date and source revision:** Not verified
- **Expected result:** Relevant metrics and logs are collected and can be inspected safely.
- **Observed result:** Runtime configuration and application logs were captured in E03. No complete verification of dashboard coverage or monitoring-system operation is included here.
- **Checks potentially supported:** O1 and O3, only to the extent supported by inspected configuration and runtime output.
- **Limitations:** Configuration files alone do not prove that metrics are available, dashboards are useful, logs are retained appropriately, or alerts are delivered.
- **Next action:** Verify the monitoring stack, capture relevant dashboard or query results, and link the actual artifacts.

### E05 — Local Failover Test

- **Candidate source:** Previously performed CloudNotes failover exercise; original script and output have not yet been verified in the current evidence set.
- **Type:** Failure and recovery test
- **Capture date and source revision:** Not verified
- **Expected result:** The service recovers after the tested component fails, and the required application behavior and data integrity are preserved.
- **Observed result:** A previous report described approximately 5.412 seconds to recovery, stable recovery, preservation of baseline records, and successful new-note write/read. The original supporting output has not been located and verified for this evidence index.
- **Checks potentially supported:** R2 only after the original test artifact is recovered and inspected; R4 only if the test also supports the relevant capacity or dependency claim.
- **Limitations:** The previously reported result is not treated as verified evidence. Local failover does not prove database restoration, regional recovery, or production availability.
- **Next action:** Locate or rerun the test, save its actual output, record the tested revision, and compare the result with agreed recovery objectives.

### E06 — Observability Test Results

- **Candidate sources:** Actual dashboard screenshots, metrics/query output, alert test output, logs, and notification records
- **Type:** Runtime observability evidence
- **Capture date and source revision:** Not verified for a complete observability test
- **Expected result:** Required signals are visible, alerts trigger under the intended conditions, notifications reach the responsible responder, and the response process is defined.
- **Observed result:** The runtime capture in E03 includes sampled CloudNotes logs with successful `/health` and `/ready` responses. No verified end-to-end alert delivery or response test is included.
- **Checks potentially supported:** O1 and O3 in a limited scope, where the specific output supports the claim.
- **Limitations:** Sampled request logs do not demonstrate dashboard coverage, alert correctness, notification delivery, or incident response. O2 and O4 remain unverified until their specific requirements are evidenced.
- **Next action:** Capture a real alert test, notification result, dashboard/query output, and documented response or escalation evidence.

### E07 — Security Review

- **Candidate sources:** Actual access-boundary tests, secret-handling review, dependency/security audit results, and relevant sanitized configuration
- **Type:** Security evidence
- **Capture date and source revision:** Not verified for a complete security assessment
- **Expected result:** Required access boundaries are enforced, secrets are protected, dependencies are assessed, and network restrictions behave as intended.
- **Observed result:** E03 shows that the CloudNotes deployment references a database URL Secret and that a PostgreSQL NetworkPolicy is configured. PostgreSQL logs also contain a warning that `trust` authentication was enabled for local connections during initialization.
- **Checks potentially supported:** S2 and S4 only as limited configuration observations; no security gate is considered passed on this evidence alone.
- **Limitations:** Secret references do not prove that credentials are securely stored, access-controlled, or rotated. A NetworkPolicy manifest does not prove enforcement. The PostgreSQL warning requires inspection of the effective authentication configuration; it is not by itself proof of remote exposure.
- **Next action:** Verify effective database authentication settings, run authorized access-boundary tests, inspect dependency/security audit output, and confirm that no credentials are exposed in committed files or evidence artifacts.
- **Safety note:** Do not include secret values, passwords, tokens, private kubeconfigs, or other credentials in the evidence artifacts.

### E08 — Backup and Restore

- **Candidate sources:** Actual backup execution records, backup artifacts, isolated restore/integrity test output, and recovery measurements
- **Type:** Disaster recovery evidence
- **Capture date and source revision:** Not verified
- **Expected result:** Required data can be restored, integrity checks pass, and recovery timing and data loss are measured against agreed RTO/RPO.
- **Observed result:** No verified database restore and integrity-test result is included in the current evidence set.
- **Checks potentially supported:** D1–D4 only when the relevant backup, restore, recovery, and ownership requirements are directly demonstrated.
- **Limitations:** Kubernetes backup manifests, persistent-volume configuration, and local failover do not prove that application data can be restored. No recovery objective has been verified.
- **Next action:** Capture an actual backup, restore it in an isolated environment, verify data integrity, measure recovery time and data loss, and compare the results with agreed RTO/RPO.

### E09 — Baseline Cost Estimate

- **Candidate source:** Previously reported Google Cloud Pricing Calculator Screenshot 2; the original screenshot has not yet been verified as an accessible artifact.
- **Type:** Cloud cost estimate
- **Estimate date and assumptions:** Reported as 2026-10-14; screenshot, region, currency, services, usage assumptions and estimate scope still require verification.
- **Expected result:** The baseline estimate uses a documented pricing basis and clearly stated assumptions.
- **Observed result:** A previously reported baseline estimate is $561.77 per month. This figure remains unverified until its supporting calculator output and assumptions are available.
- **Checks potentially supported:** C1 and C2 only after the estimate and its assumptions are inspected.
- **Limitations:** This is a reported estimate, not an invoice or measured production spend. It must not be presented as actual expenditure.
- **Next action:** Locate the original screenshot or reproduce the calculator estimate, document assumptions, and add an accessible sanitized artifact.

### E10 — Optimized Cost Estimate

- **Candidate source:** Previously reported Google Cloud Pricing Calculator Screenshot 4; the original screenshot has not yet been verified as an accessible artifact.
- **Type:** Cloud cost estimate
- **Estimate date and assumptions:** Reported as 2026-10-14; screenshot, region, currency, services, usage assumptions and estimate scope still require verification.
- **Expected result:** The optimized estimate uses a comparable pricing basis and documented assumptions.
- **Observed result:** A previously reported optimized estimate is $400.01 per month. This figure remains unverified until its supporting calculator output and assumptions are available.
- **Checks potentially supported:** C1 and C2 only after the estimate and its assumptions are inspected.
- **Limitations:** Estimated savings do not prove production performance, actual consumption, or realized savings.
- **Next action:** Locate the original screenshot or reproduce the estimate using the same scope and comparable assumptions as E09.

### E11 — Cost Comparison

- **Candidate source:** Previously reported Google Cloud Pricing Calculator Screenshot 5 or comparison artifact; original evidence has not yet been verified.
- **Type:** Cost comparison
- **Capture date and source revision:** Not verified
- **Expected result:** Baseline and optimized estimates are compared using consistent scope, region, currency, and usage assumptions.
- **Observed result:** Based on the previously reported figures, the arithmetic difference is $161.76 per month, approximately 28.79% of the reported baseline. The underlying estimates remain unverified.
- **Checks potentially supported:** C1 and C2 after source verification. C3 and C4 require their own direct evidence.
- **Limitations:** The calculated difference is not evidence of realized savings. Excluded services, pricing changes, taxes and usage variation may affect actual cost.
- **Next action:** Verify E09 and E10, preserve the comparison output, and document assumptions and exclusions.

### E12 — Local Ingress Forwarding Test

- **Candidate source:** Terminal output from the local Minikube ingress forwarding test; the exact command output should be retained in an accessible evidence artifact.
- **Type:** Runtime connectivity test
- **Test date:** 2026-10-14
- **Environment:** Local Minikube/Kubernetes cluster
- **Git revision at test:** `3837a0cbecc5ce740cc36309aafe6d49547d9e94`; running image-to-commit mapping is unverified
- **Expected result:** Requests using the `cloudnotes.local` host reach the application health endpoints.
- **Observed result:** The reported test used `curl` against `http://127.0.0.1:33179/health` and `/ready` with the `Host: cloudnotes.local` header. The responses were reported as HTTP 200 with JSON output.
- **Checks potentially supported:** R3 and limited aspects of R4 for local routing and endpoint behavior.
- **Limitations:** The test used a local Minikube forwarding URL. It does not prove public ingress behavior, TLS correctness, sustained availability, failover, or production performance.
- **Next action:** Ensure the sanitized terminal output is saved in the repository and link the exact artifact.

### E13 — Captured Local Baseline and Runtime Configuration

- **Evidence artifacts:**
  - `production-readiness/evidence/local-baseline.txt`
  - `production-readiness/evidence/runtime-configuration.txt`
- **Type:** Automated test output and Kubernetes runtime/configuration capture
- **Capture date:** 2026-10-14
- **Environment:** Local development environment using Minikube/Kubernetes
- **Git revision at capture:** `3837a0cbecc5ce740cc36309aafe6d49547d9e94`
- **Expected result:** Automated tests complete and the current Kubernetes workload, services, ingress, probes, resource settings, and network policy can be inspected.
- **Observed result:** The captured test run reported 2 passed tests and 1 Flask deprecation warning. The captured cluster output showed three CloudNotes pods and one PostgreSQL pod Ready. The CloudNotes deployment defined health probes and CPU/memory requests and limits. A PostgreSQL NetworkPolicy was configured.
- **Checks potentially supported:** R3; limited aspects of R4; O3 for the sampled application logs; S4 for the existence of the NetworkPolicy configuration.
- **Limitations:** The working tree contained uncommitted changes during capture, and the deployed image was `localhost:5000/cloudnotes:1.0.1`; its relationship to the captured Git revision is unverified. The capture does not prove policy enforcement, alert delivery, failover, database restoration, or production readiness.
- **Evidence handling:** Inspect the artifacts for sensitive values before committing them. The evidence should show Secret references, not Secret contents.

## 3. Evidence Gaps and Follow-up Plan

The following evidence is still needed before the associated controls can be considered verified:

1. **Reliability:** Recover or rerun the local failover test and preserve the actual output. Define the intended workload and availability targets with the service owner.
2. **Observability:** Verify monitoring coverage, capture a real alert trigger and delivery result, and document the responder and response process.
3. **Security:** Verify effective database authentication, conduct authorized access-boundary tests, inspect dependency/security audit results, and confirm that network restrictions are enforced.
4. **Disaster recovery:** Produce actual backup and isolated restore evidence, verify restored data integrity, measure recovery time and data loss, and compare results against agreed RTO/RPO.
5. **Cost:** Locate or reproduce the baseline and optimized calculator outputs. Document region, currency, service scope, usage assumptions, exclusions and estimate date.
6. **Evidence integrity:** Check every artifact's repository-relative path, capture date, environment, source revision, expected result, observed result and limitations. Explicitly record unknown metadata.
7. **Ownership and retesting:** Assign an accountable person and a realistic, agreed target date to each unresolved gap. Record the measurable retest required for closure.

## 4. Scoring and Decision Rules

- `PASS` = 2 points
- `PARTIAL` = 1 point
- `FAIL` = 0 points
- `UNVERIFIED` = 0 points

Every checklist row must cite an evidence ID that directly supports its claim, or explicitly identify missing evidence and the planned retest.

The readiness verdict must use the completed checklist scores and mandatory gates. A configured control is not automatically a passing control. Do not claim a production GO unless all required dimension thresholds, overall score, mandatory gates and critical-gap conditions are met.

**Current evidence limitation:** This index records limited local test and configuration observations, along with several reported but not yet verified artifacts. It is not a production certification and does not independently establish that CloudNotes is production-ready.
