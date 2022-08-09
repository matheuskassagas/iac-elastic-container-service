resource "aws_security_group" "alb" {
  name = "alb_ECS"
  vpc_id = module.vpc.vpc_id
}

resource "aws_secutiry_group_rule" "alb_role"{
  type = "ingress"
  from_port = 8000
  to_port = 8000
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # # 0.0.0.0 -> 255.255.255.255
  security_group_id = aws_security_group.alb.id
}

resource "aws_secutiry_group_rule" "alb_role"{
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"] # # 0.0.0.0 -> 255.255.255.255
  security_group_id = aws_security_group.alb.id
}

