resource "aws_iam_role" "this" {
  name               = var.cluster_role_name
  assume_role_policy = file("${path.module}/eks-iam-cluster-policy.json")
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each   = toset(var.eks_cluster_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.value
}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.this.arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }
  version    = var.kubernetes_version
  depends_on = [aws_iam_role_policy_attachment.this]
  tags       = var.tags
}
