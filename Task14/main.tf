module "network" {
  source = "./modules/network"

  vpc_cidr       = var.vpc_cidr
  vpc_name       = var.vpc_name
  subnet_configs = var.subnet_configs
  internet_gw    = var.internet_gw
  route_table    = var.route_table
}

module "network_security" {
  source = "./modules/network_security"

  vpc_id           = module.network.vpc_id
  ssh_sg           = var.ssh_sg
  public_http_sg   = var.public_http_sg
  private_http_sg  = var.private_http_sg
  allowed_ip_range = var.allowed_ip_range
}

module "application" {
  source = "./modules/application"

  template_name     = var.template_name
  asg_name          = var.asg_name
  applb_name        = var.applb_name
  target_group_name = var.target_group_name

  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.subnet_ids
  ssh_sg_id          = module.network_security.ssh_sg_id
  public_http_sg_id  = module.network_security.public_http_sg_id
  private_http_sg_id = module.network_security.private_http_sg_id
}
