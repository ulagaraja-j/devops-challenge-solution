variable "name" {
  description = "Base name for the ALB"
  type        = string
}

variable "load_balancer_type" {
  description = "Type of ELB to be used"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group for the ALB"
  type        = string
}

variable "tags" {
  description = "Common tags to be applied"
  type        = map(string)
}
