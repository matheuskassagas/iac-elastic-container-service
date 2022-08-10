module "producao" {
  source = "../../infra"
  name_repo = "producao"
  cargoIAM = "producao"
  ambiante = "producao"
}

output "IP_alb" {
 value = module.producao.IP  
}
