dr-setup/
├── main.tf
├── variables.tf
├── outputs.tf
├── primary/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
├── secondary/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
├── data-replication/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
├── failover/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
└── README.md



<h2>Components</h2>

**Primary Region**

- This module defines the infrastructure in the primary region, including VPC, subnets, and EC2 instances.

**Secondary Region**
 
- This module defines the infrastructure in the secondary region, similar to the primary region.

**Data Replication**
 
- This module sets up data replication between the primary and secondary regions using DynamoDB Global Tables.

**Failover**

- This module configures Route 53 DNS records and load balancers for automated failover between primary and secondary regions.
