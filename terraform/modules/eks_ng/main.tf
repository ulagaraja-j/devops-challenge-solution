resource "aws_iam_role" "node_role" {
  name               = var.node_role_name
  assume_role_policy = file("${path.module}/eks-iam-node-policy.json")
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "node_policy_attachments" {
  for_each   = toset(var.node_group_policy_arns)
  role       = aws_iam_role.node_role.name
  policy_arn = each.value
}

resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  instance_types = var.instance_types
  ami_type       = var.ami_type
  disk_size      = var.boot_size
  depends_on = [
    aws_iam_role_policy_attachment.node_policy_attachments
  ]
  tags = var.tags
}
