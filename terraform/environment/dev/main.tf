module "vpc" {

  source = "../../modules/vpc"

  project_name = "ecommerce"
  environment  = "dev"

  vpc_cidr = "10.0.0.0/16"

  public_subnet_1_cidr = "10.0.1.0/24"
  public_subnet_2_cidr = "10.0.2.0/24"

  private_app_subnet_1_cidr = "10.0.11.0/24"
  private_app_subnet_2_cidr = "10.0.12.0/24"

  private_db_subnet_1_cidr = "10.0.21.0/24"
  private_db_subnet_2_cidr = "10.0.22.0/24"

}

module "security" {

  source = "../../modules/security"

  vpc_id = module.vpc.vpc_id

}


# module "backend" {

#   source = "../../modules/backend"

# }


module "ecr" {

  source = "../../modules/ecr"

  repository_name = "ecommerce-app"

}

module "flowlogs" {

  source = "../../modules/flowlogs"

  vpc_id = module.vpc.vpc_id

}

module "iam" {

  source = "../../modules/iam"

  role_name = "eks-admin-role"

}


module "eks" {

  source = "../../modules/eks"

  cluster_name = "ecommerce-eks"

  private_subnet_ids = module.vpc.private_app_subnet_ids

}
