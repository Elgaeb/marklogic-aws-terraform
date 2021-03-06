locals {
  internal_ports = [ for port in local.ports: port if port.ingress_enabled && port.internal_lb ]
  internal_http_ports = [ for port in local.ports: port if port.ingress_enabled && port.internal_lb && (port.lb_protocol == "http" || port.lb_protocol == "https" ) ]
}

resource "aws_security_group" "internal_elb_security_group" {
  name        = "${var.cluster_name}-internal_elb"

  description = "Security group for the internal-facing load balancer"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.internal_ports
    content {
      description = ingress.value.description
      protocol    = "tcp"
      from_port   = ingress.value.lb_port
      to_port     = ingress.value.lb_port
      cidr_blocks = [
        "0.0.0.0/0",
      ]
    }
  }

  dynamic "egress" {
    for_each = local.internal_ports
    content {
      description = egress.value.description
      protocol    = "tcp"
      from_port   = egress.value.instance_port
      to_port     = egress.value.instance_port

      security_groups = [ aws_security_group.instance_security_group.id ]
    }
  }

  tags = {
    Name = "Internal-facing ELB Security Group"
    Terraform = true
  }
}

resource "aws_elb" "internal_elb" {
  name = "${var.cluster_name}-internal-elb"

  security_groups = [
    aws_security_group.internal_elb_security_group.id
  ]

  subnets = var.private_subnet_ids

  idle_timeout = 300

  connection_draining         = true
  connection_draining_timeout = 60
  cross_zone_load_balancing   = true

  health_check {
    healthy_threshold   = 3
    interval            = 10
    target              = "HTTP:7997/"
    timeout             = 5
    unhealthy_threshold = 5
  }

  // <editor-fold desc="Listeners">

  dynamic "listener" {
    for_each = local.internal_ports

    content {
      instance_port     = listener.value.instance_port
      instance_protocol = listener.value.instance_protocol
      lb_port           = listener.value.lb_port
      lb_protocol       = listener.value.lb_protocol
    }
  }

  tags = {
    Name      = "${var.cluster_name}-internal-elb"
    Terraform = true
  }
}

resource "aws_app_cookie_stickiness_policy" "internal_elb_csp" {
  count = length(local.internal_http_ports)

  name          = format("%s-internal-elb-csp-%d", var.cluster_name, local.internal_http_ports[count.index].lb_port)
  load_balancer = aws_elb.internal_elb.name
  lb_port       = local.internal_http_ports[count.index].lb_port
  cookie_name   = "SessionID"
}

//output "internal_ports" {
//  value = local.internal_ports
//}
//
//output "internal_http_ports" {
//  value = local.internal_http_ports
//}
