resource "aws_security_group" "instance_security_group" {
  description = "Security group for the MarkLogic cluster"

  name        = "${var.cluster_name}-instance_security_group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [ for port in local.ports: port if port.ingress_enabled ]
    content {
      description = ingress.value.description
      protocol    = "tcp"
      from_port   = ingress.value.instance_port
      to_port     = ingress.value.instance_port
      cidr_blocks = [ var.vpc_cidr ]
    }
  }

  ingress {
    description = "All communication within the security group"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    self        = true
  }

  egress {
    description = "HTTP"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    description = "HTTPS"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    description = "TCP within the VPC"
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535

    cidr_blocks = [
      var.vpc_cidr
    ]
  }

  tags = {
    Name = "MarkLogic Cluster Security Group"
    Terraform = true
  }
}