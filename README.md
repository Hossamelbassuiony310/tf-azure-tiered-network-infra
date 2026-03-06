# Project Description

**tf-azure-tiered-network-infra** is a modular, secure-by-design Terraform project that implements a **tiered network architecture on Microsoft Azure**.

The infrastructure follows the **Defense-in-Depth security model**, isolating workloads into multiple network tiers to minimize the attack surface and enforce strict access control.

### Architecture Overview

The network is segmented into two main tiers:

- **Public Tier**
  
  Hosts a **Jumpbox (Bastion) virtual machine** that provides controlled administrative SSH access to internal resources.

- **Private Tier**
  
  Hosts backend virtual machines that **have no public internet exposure**, ensuring that sensitive workloads remain isolated within the virtual network.

### Key Features

- **Zero-Trust Networking**  
  All traffic to the private tier is strictly controlled using Azure **Network Security Groups (NSGs)**.

- **Tiered Network Segmentation**  
  Workloads are separated into public and private subnets to enforce strict access boundaries.

- **Modular Terraform Design**  
  Infrastructure is implemented using reusable Terraform modules for **VNet, Subnets, NSGs, and Virtual Machines**.

- **Secure Administrative Access**  
  Private resources can only be accessed via the **Jumpbox using internal SSH communication**.

- **Infrastructure as Code (IaC)**  
  The entire environment is provisioned and managed through Terraform to ensure consistency, repeatability, and automated security policy enforcement.


## Diagram

![Azure Tiered Network Architecture](diagram/AWS-Resource-Creation-Flow-2026-03-06-145648.png)