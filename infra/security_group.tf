resource "aws_security_group" "alb" {
  name = "alb_ECS"
  vpc_id = module.vpc.vpc_id
}

resource "aws_secutiry_group_rule" "alb_role_entrada"{
  type = "ingress"
  from_port = 8000
  to_port = 8000
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # # 0.0.0.0 -> 255.255.255.255
  security_group_id = aws_security_group.alb.id
}

resource "aws_secutiry_group_rule" "alb_role_saida" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"] # # 0.0.0.0 -> 255.255.255.255
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group" "private" {
  name = "private_ECS"
  vpc_id = module.vpc.vpc_id
}

resource "aws_secutiry_group_rule" "entrada_ecs"{
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  source_security_group_id = aws_security_group.alb.id # # JUST FROM ALB
  security_group_id = aws_security_group.privado.id
}

resource "aws_secutiry_group_rule" "saida_ecs"{
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"] # # 0.0.0.0 -> 255.255.255.255
  security_group_id = aws_security_group.privado.id
}