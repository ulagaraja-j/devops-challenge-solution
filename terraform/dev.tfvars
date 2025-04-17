#VPC Configuration
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]
private_subnet_cidrs = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]
availability_zones = [
  "us-east-1a",
  "us-east-1b"
]
vpc_tags = {
  Name        = "simpletimeservice-vpc"
  Environment = "dev"
  Product     = "simpletimeservice"
}

# EKS Configuration
cluster_name       = "simpletimeservice-eks-cluster"
cluster_role_name  = "simpletimeservice-eks-cluster-iam-role"
kubernetes_version = "1.30"
cluster_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
  "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
]
eks_tags = {
  Name        = "simpletimeservice-eks",
  Environment = "dev",
  Product     = "simpletimeservice"
}

#ELB Configuration
elb_name           = "simpletimeservice-alb"
load_balancer_type = "application"
elb_tags = {
  Name        = "simpletimeservice-elb",
  Environment = "dev",
  Product     = "simpletimeservice"
}

#EKS_NG Configuration
node_group_name   = "simpletimeservice-ng"
node_desired_size = 1
node_min_size     = 1
node_max_size     = 2
instance_types    = ["t2.micro"]
ami_type          = "AL2_x86_64"
boot_size         = 20
node_role_name    = "simpletimeservice-ng-iam-role"
node_group_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
]
tags = {
  Name        = "simpletimeservice-ng"
  Environment = "dev"
  Product     = "simpletimeservice"
}
