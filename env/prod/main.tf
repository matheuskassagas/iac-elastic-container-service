module "producao" {
  source = "../../infra"
  name_repo = "producao"
}

output "IP_alb" {
 value = module.producao.IP  
}