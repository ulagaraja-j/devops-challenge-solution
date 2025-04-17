variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "node_group_name" {
  type        = string
  description = "Name of the EKS node group"
}

variable "node_role_name" {
  type        = string
  description = "IAM role name for the node group"
}

variable "node_desired_size" {
  type        = number
  description = "Desired number of nodes in the node group"
}

variable "node_min_size" {
  type        = number
  default     = 1
  description = "Minimum number of nodes in the node group"
}

variable "node_max_size" {
  type        = number
  description = "Maximum number of nodes in the node group"
}

variable "instance_types" {
  type        = list(string)
  description = "List of EC2 instance types for the EKS node group"
}

variable "ami_type" {
  type        = string
  description = "AMI type for the EKS node group (e.g., AL2_x86_64)"
}

variable "boot_size" {
  type        = number
  description = "Root EBS volume size (in GiB) for the EC2 instances"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the node group"
}

variable "node_group_policy_arns" {
  type        = list(string)
  description = "List of IAM policy ARNs to attach to the node group role"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}
