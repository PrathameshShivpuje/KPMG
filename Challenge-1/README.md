# Three-Tier Architecture on Azure with Terraform

The architecture consists of:

1. **Web Tier**: It will handles incoming web traffic and serves static or dynamic content from users.
2. **Application Tier**: It will Contains the business logic and application code, processing requests from the web tier.
3. **Database Tier**: Stores and manages application data.

## Architecture Overview

The architecture is structured as follows:

- **External Load Balancer**: Routes incoming traffic from the internet to the web tier.
- **Virtual Network**: Provides network isolation for the infrastructure components.
- **Subnets**:
  - **Web Subnet**: For web servers.
  - **App Subnet**: For application servers.
  - **Database Subnet**: For database servers.
- **Virtual Machine Scale Sets (VMSS)**: Autoscaling groups for the web and application tiers.
- **Internal Load Balancer**: Distributes traffic within the application tier.
- **Azure SQL Database**: Managed relational database service for storing application data.

## Architecture Diagram

<img width="595" alt="image" src="https://github.com/PrathameshShivpuje/KPMG/assets/139623766/098dada3-67ea-412d-a9b0-6b099c651bae">


