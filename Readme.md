# AWS EKS Scalable Infrastructure using Terraform

## Overview

This repository contains Terraform code to provision a **highly available, scalable, secure, and cost-optimized AWS infrastructure** for a customer engagement platform that serves millions of users and experiences traffic spikes during promotional campaigns.

The infrastructure is designed with **long-term maintainability** in mind and follows AWS and Terraform best practices.

---

## High-Level Architecture

The solution includes:

* **Multi-AZ VPC** with public and private subnets
* **Amazon EKS** with managed node groups for scalable compute
* **Application Load Balancer (ALB)** for ingress traffic
* **Amazon Aurora (RDS)** for relational data
* **Amazon ElastiCache (Redis)** for low-latency caching
* **Amazon S3** for logs and object storage
* **Amazon ECR** for container image storage
* **IAM** with least-privilege roles
* **Encryption** using AWS-managed KMS keys
* Designed for **CI/CD integration** using GitHub Actions

(Refer to the architecture diagram included in the repository for a visual representation.)

---

## Why Terraform

Terraform was chosen because:

* It provides **declarative, version-controlled infrastructure**
* Enables **reusable modules** and consistent environments
* Supports **safe change management** via plan/apply
* Has strong AWS support and a mature ecosystem

---

## Terraform Module Strategy

This project makes extensive use of **official public Terraform AWS modules** maintained by the community:

* [`terraform-aws-modules/vpc/aws`](https://github.com/terraform-aws-modules/terraform-aws-vpc)
* [`terraform-aws-modules/eks/aws`](https://github.com/terraform-aws-modules/terraform-aws-eks)
* [`terraform-aws-modules/alb/aws`](https://github.com/terraform-aws-modules/terraform-aws-alb)
* [`terraform-aws-modules/rds/aws`](https://github.com/terraform-aws-modules/terraform-aws-rds)
* [`terraform-aws-modules/s3-bucket/aws`](https://github.com/terraform-aws-modules/terraform-aws-s3-bucket)

### Why Public Modules?

* Battle-tested and widely adopted
* Reduce boilerplate code
* Follow AWS best practices by default
* Easier maintenance and upgrades

---

## Working in Restricted / Private Networks

In environments where **access to public Terraform registries is restricted** (e.g. private networks, regulated environments, air-gapped setups), the following workaround can be used:

### Recommended Workaround

1. Download the required Terraform modules from the public registry:

   ```bash
   terraform init
   terraform providers lock
   ```

   or clone the module repositories directly.

2. Store the modules in an **internal Git repository or shared folder** accessible within the network.

3. Update the module source references, for example:

   ```hcl
   source = "../modules/terraform-aws-vpc"
   ```

   or

   ```hcl
   source = "git::ssh://git.internal.company/terraform/terraform-aws-vpc.git"
   ```

This approach allows the same Terraform codebase to be used in **enterprise or restricted environments** without relying on external connectivity.

---

## Repository Structure

```text
aws-scalable-architecture
├──terraform/
│   ├── versions.tf
│   ├── providers.tf
│   ├── backend.tf
│   ├── variables.tf
│   ├── locals.tf
│   ├── outputs.tf
│   ├── vpc.tf
│   ├── security-groups.tf
│   ├── iam.tf
│   ├── eks.tf
│   ├── alb.tf
│   ├── rds.tf
│   ├── redis.tf
│   ├── s3.tf
│   └── ecr.tf
├── .gitignore
├── AWS_Architecture.jpg
├── AWS_Architecture.drawio
└── Readme.md (This file)
```

Each file is scoped to a specific infrastructure concern to improve readability and maintainability.

---

## Security Considerations

* **Private subnets** for EKS, RDS, and Redis
* **Security group to security group rules** instead of open CIDRs
* **IAM roles with least privilege**
* **Encryption at rest and in transit** (RDS, Redis, S3)
* **No public access** to databases or cache layers

---

## Cost Optimization Strategies

* Managed services (EKS, Aurora, ElastiCache) to reduce operational overhead
* Auto-scaling EKS managed node groups
* Single NAT Gateway (trade-off documented)
* S3 lifecycle rules for log retention
* Right-sized instance types

---

## CI/CD Integration (Conceptual)

This infrastructure is designed to be deployed via CI/CD pipelines such as **GitHub Actions**:

1. Code push triggers Terraform plan
2. Manual approval (optional)
3. Terraform apply to provision or update infrastructure
4. Optional Helm-based application deployment to EKS

---

## Assumptions & Notes

* Terraform state backend resources (S3 & DynamoDB) are assumed to exist
* Application-level Kubernetes manifests and Helm charts are out of scope
* IAM Roles for Service Accounts (IRSA) can be added for fine-grained pod permissions

---

## Conclusion

This Terraform project demonstrates a **production-ready AWS architecture** that meets requirements for scalability, security, automation, and cost efficiency, while remaining flexible and maintainable for future growth.