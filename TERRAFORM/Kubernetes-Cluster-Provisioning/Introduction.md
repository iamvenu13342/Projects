
<h1>3. Kubernetes Cluster Provisioning<h1>
  
<h2>Project Description:</h2>

Automate the provisioning of a Kubernetes cluster on AWS using EKS (Elastic Kubernetes Service).


<h2>Key Components:</h2>

- **EKS Provider:** Use Terraform’s EKS provider to manage Kubernetes clusters.

- **Node Groups:** Define and manage node groups within the cluster.

- **IAM Roles and Policies:** Configure necessary IAM roles and policies.


<h2>Steps:</h2>

1. **Setup EKS Cluster:**

   ```hcl
   module "eks" {
     source          = "terraform-aws-modules/eks/aws"
     cluster_name    = "my-cluster"
     cluster_version = "1.21"
     subnets         = module.vpc.private_subnets
     vpc_id          = module.vpc.vpc_id
   }
   ```

2. **Define Node Group:**
 
   ```hcl
   module "eks_workers" {
     source          = "terraform-aws-modules/eks/aws//modules/node_groups"
     cluster_name    = module.eks.cluster_name
     node_group_name = "example"
     node_group_desired_capacity = 2
     node_group_max_capacity     = 3
     node_group_min_capacity     = 1
   }
   ```

3. **Configure IAM Roles:**
 
   ```hcl
   resource "aws_iam_role" "eks_node_group" {
     name = "eks-node-group-role"
   
     assume_role_policy = jsonencode({
       Version = "2012-10-17"
       Statement = [{
         Action = "sts:AssumeRole"
         Effect = "Allow"
         Principal = {
           Service = "ec2.amazonaws.com"
         }
       }]
     })
   }
   
   resource "aws_iam_role_policy_attachment" "eks_worker_attach" {
     role       = aws_iam_role.eks_node_group.name
     policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
   }
   ```


<h2> Benefits:</h2>.

- **Ease of Management:** Simplifies the management of Kubernetes clusters.

- **Scalability:** Easily scale the cluster by adjusting node group configurations.

