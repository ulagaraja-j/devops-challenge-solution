module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.vpc_tags
}

module "eks_cluster" {
  source                  = "./modules/eks"
  cluster_name            = var.cluster_name
  cluster_role_name       = var.cluster_role_name
  eks_cluster_policy_arns = var.cluster_policy_arns
  private_subnet_ids      = module.vpc.private_subnet_ids
  kubernetes_version      = var.kubernetes_version
  tags                    = var.eks_tags
  depends_on              = [module.vpc]
}

module "eks_cluster_ng" {
  source                 = "./modules/eks_ng"
  cluster_name           = module.eks_cluster.cluster_name
  node_role_name         = var.node_role_name
  node_group_policy_arns = var.node_group_policy_arns
  node_group_name        = var.node_group_name
  node_desired_size      = var.node_desired_size
  node_min_size          = var.node_min_size
  node_max_size          = var.node_max_size
  instance_types         = var.instance_types
  ami_type               = var.ami_type
  boot_size              = var.boot_size
  subnet_ids             = module.vpc.private_subnet_ids
  tags                   = var.tags
  depends_on             = [module.vpc, module.eks_cluster]
}


module "elb" {
  source             = "./modules/elb"
  name               = var.elb_name
  load_balancer_type = var.load_balancer_type
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_id  = module.vpc.eks_security_group_id
  tags               = var.elb_tags
  depends_on         = [module.eks_cluster, module.vpc]
}


