module "vpc" {
  source = "../modules/vpc"
}

module "iam" {
  source = "../modules/iam"
}

module "ec2" {
  source                    = "../modules/ec2"
  vpc_id                    = module.vpc.main.id
  subnet_id                 = element(module.vpc.public_subnets, 0).id                # Place in the first public subnet
  availability_zone         = element(module.vpc.public_subnets, 0).availability_zone # Place in the first AZ of the VPC
  ec2_instance_profile_name = module.iam.ec2_instance_profile.name
}
