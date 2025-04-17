variable "cluster_name" {
  description = "Name for the EKS cluster"
  type        = string
}

variable "cluster_role_name" {
  description = "IAM policy for the EKS Cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for EKS"
  type        = string
}

variable "eks_tags" {
  description = "Map of tags to assign to all resources"
  type        = map(string)
}

variable "cluster_policy_arns" {
  description = "EKS cluster policies as list"
  type        = list(string)
}
