locals {
  external_ports = [ for port in local.ports: port if port.ingress_enabled && port.external_lb ]
  external_http_ports = [ for port in local.ports: port if port.ingress_enabled && port.external_lb && (port.lb_protocol == "http" || port.lb_protocol == "https" ) ]

  enable_external_load_balancer = var.enable_external_load_balancer ? 1 : 0
}

resource "aws_security_group" "external_elb_security_group" {
  count = local.enable_external_load_balancer

  name        = "${var.cluster_name}-external_elb"

  description = "Security group for the external-facing load balancer"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.external_ports
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
    for_each = local.external_ports
    content {
      description = egress.value.description
      protocol    = "tcp"
      from_port   = egress.value.instance_port
      to_port     = egress.value.instance_port

      security_groups = [ aws_security_group.instance_security_group.id ]
    }
  }

  tags = {
    Name = "External-facing ELB Security Group"
    Terraform = true
  }
}

resource "aws_elb" "external_elb" {
  count = local.enable_external_load_balancer

  name = "${var.cluster_name}-external-elb"

  security_groups = [
    aws_security_group.external_elb_security_group[0].id
  ]

  subnets = var.public_subnet_ids

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
    for_each = local.external_ports

    content {
      instance_port     = listener.value.instance_port
      instance_protocol = listener.value.instance_protocol
      lb_port           = listener.value.lb_port
      lb_protocol       = listener.value.lb_protocol
    }
  }

  tags = {
    Name      = "${var.cluster_name}-external-elb"
    Terraform = true
  }
}

resource "aws_app_cookie_stickiness_policy" "external_elb_csp" {
  count = local.enable_external_load_balancer * length(local.external_http_ports)

  name          = format("%s-external-elb-csp-%d", var.cluster_name, local.external_http_ports[count.index].lb_port)
  load_balancer = aws_elb.external_elb[0].name
  lb_port       = local.external_http_ports[count.index].lb_port
  cookie_name   = "SessionID"
}
