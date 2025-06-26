provider "aws" {
  region = var.region
}

module "networking" {
    source                         = "./modules/networking"
    region                         = var.region
    project_name                   = var.project_name
    vpc_cidr_block                 = var.vpc_cidr_block
    public_subnet_cidr_block_1     = var.public_subnet_cidr_block_1
    public_subnet_cidr_block_2     = var.public_subnet_cidr_block_2
    private_subnet_cidr_block_1    = var.private_subnet_cidr_block_1
    private_subnet_cidr_block_2    = var.private_subnet_cidr_block_2
    private_subnet_cidr_block_3    = var.private_subnet_cidr_block_3
    private_subnet_cidr_block_4    = var.private_subnet_cidr_block_4

}

module "compute" {
    source              = "./modules/compute"
    project_name        = var.project_name
    vpc_id              = module.networking.vpc_id
    public_subnet_id_1  = module.networking.public_subnet_id_1
    ec2_ami             = var.ec2_ami
    ec2_instance_type   = var.ec2_instance_type
}