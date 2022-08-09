resource "aws_ecr_repository" "repositorio" { # # registro de imagens de contêiner gerenciado pela AWS
  name                 = var.nome_repositorio
}


