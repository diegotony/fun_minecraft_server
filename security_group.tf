resource "aws_security_group" "this" {
  name        = var.name
  description = var.description


  dynamic "ingress" {
    for_each = var.ingress
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]

    }
  }

  dynamic "egress" {
    for_each = var.egress
    content {
      description = egress.value["description"]
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]

    }
  }

  tags = var.tags
}

resource "aws_network_interface_sg_attachment" "this" {
  security_group_id    = aws_security_group.this.id
  network_interface_id = module.server.primary_network_interface_id
}