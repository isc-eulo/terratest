module "autoscaling" {//importar modulo escalar
  source      = "./modules/autoscaling"
  namespace   = var.namespace
  ssh_keypair = var.ssh_keypair

  vpc       = module.networking.vpc
  sg        = module.networking.sg
  db_config = module.database.db_config
}

 
module "database" {//importar modulo base de datos
  source    = "./modules/database"
  namespace = var.namespace
  vpc = module.networking.vpc
  sg  = module.networking.sg
}

 module "networking" {
  source    = "./modules/networking"
  namespace = var.namespace
}


