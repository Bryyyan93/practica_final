module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

}
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = module.iam.eks_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}