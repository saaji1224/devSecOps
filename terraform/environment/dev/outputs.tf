output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "alb_security_group" {
  value = module.security.alb_sg_id
}

output "app_security_group" {
  value = module.security.app_sg_id
}

output "db_security_group" {
  value = module.security.db_sg_id
}

# modules/
#    ↓
# Write code only

# environment/dev
#    ↓
# init
# plan
# apply
# destroy

# EKS Outputs

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_arn" {
  value = module.eks.cluster_arn
}