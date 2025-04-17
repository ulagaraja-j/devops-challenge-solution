variable "elb_tags" {
  description = "Map of tags to assign to all resources"
  type        = map(string)
}

variable "load_balancer_type" {
  description = "Type of ELB to be used"
  type        = string
}

variable "elb_name" {
  description = "ELB Name"
  type        = string
}
