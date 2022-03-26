output "db_password" {//se setea el password
  value = module.database.db_config.password
   sensitive = true
}
 
output "lb_dns_name" {//auto escalin
  value = module.autoscaling.lb_dns_name
}
