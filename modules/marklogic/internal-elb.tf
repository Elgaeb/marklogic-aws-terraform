// <editor-fold desc="ELB">

// <editor-fold desc="Security Group">

resource "aws_security_group" "internal_elb_security_group" {
  name        = "${var.cluster_name}-internal_elb_security_group"
  description = "Enable SSH access and HTTP access on the inbound port"
  vpc_id      = "${var.vpc_id}"
//  vpc_id      = "${var.vpc_id}"


  tags = {
    Name = "Internal ELB Security Group"
  }
}

resource "aws_security_group_rule" "internal_elb_security_group_egress_rule" {
  type      = "egress"
  protocol  = "tcp"
  from_port = 0
  to_port   = 65535

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.internal_elb_security_group.id}"
}

// <editor-fold desc="Ingress Rules">

resource "aws_security_group_rule" "internal_elb_security_group_ml_system_ingress_rule" {
  type      = "ingress"
  protocol  = "tcp"
  from_port = 7997
  to_port   = 7998

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.internal_elb_security_group.id}"
}

resource "aws_security_group_rule" "internal_elb_security_group_ml_administration_ingress_rule" {
  type      = "ingress"
  protocol  = "tcp"
  from_port = 8000
  to_port   = 8002

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.internal_elb_security_group.id}"
}

resource "aws_security_group_rule" "internal_elb_security_group_ops_director_ingress_rule" {
  count = "${var.enable_ops_director ? 1 : 0}"

  type      = "ingress"
  protocol  = "tcp"
  from_port = 8008
  to_port   = 8008

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.internal_elb_security_group.id}"
}

resource "aws_security_group_rule" "internal_elb_security_group_data_explorer_ingress_rule" {
  count = "${var.enable_data_explorer ? 1 : 0}"

  type      = "ingress"
  protocol  = "tcp"
  from_port = 7777
  to_port   = 7777

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.internal_elb_security_group.id}"
}

resource "aws_security_group_rule" "internal_elb_security_group_grove_ingress_rule" {
  count = "${var.enable_grove ? 1 : 0}"

  type      = "ingress"
  protocol  = "tcp"
  from_port = 7778
  to_port   = 7778

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.internal_elb_security_group.id}"
}

resource "aws_security_group_rule" "internal_elb_security_group_data_hub_ingress_rule" {
  count = "${var.enable_data_hub ? 1 : 0}"

  type      = "ingress"
  protocol  = "tcp"
  from_port = 8010
  to_port   = 8011

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.internal_elb_security_group.id}"
}

resource "aws_security_group_rule" "internal_elb_security_group_data_hub_jobs_ingress_rule" {
  count = "${var.enable_data_hub ? 1 : 0}"

  type      = "ingress"
  protocol  = "tcp"
  from_port = 8013
  to_port   = 8013

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = "${aws_security_group.internal_elb_security_group.id}"
}

// </editor-fold>

// </editor-fold>

resource "aws_elb" "internal_elastic_load_balancer" {
  name = "ilb-${var.cluster_name}"

  security_groups = [
    "${aws_security_group.internal_elb_security_group.id}",
  ]

//  subnets = "${var.private_subnet_ids}"
  subnets = "${var.private_subnet_ids}"

  internal = true

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

  // <editor-fold desc="MarkLogic Administration">

  // App-Services
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 8000
    lb_protocol       = "http"
  }
  // Admin
  listener {
    instance_port     = 8001
    instance_protocol = "http"
    lb_port           = 8001
    lb_protocol       = "http"
  }
  // Manage
  listener {
    instance_port     = 8002
    instance_protocol = "http"
    lb_port           = 8002
    lb_protocol       = "http"
  }

  // </editor-fold>

  // <editor-fold desc="MarkLogic Ops Director">

  listener {
    instance_port     = 8008
    instance_protocol = "http"
    lb_port           = 8008
    lb_protocol       = "http"
  }
  listener {
    instance_port     = 8009
    instance_protocol = "http"
    lb_port           = 8009
    lb_protocol       = "http"
  }

  // </editor-fold>

  // <editor-fold desc="MarkLogic Data Explorer">

  listener {
    instance_port     = 7777
    instance_protocol = "http"
    lb_port           = 7777
    lb_protocol       = "http"
  }

  // </editor-fold>

  // <editor-fold desc="MarkLogic Grove">

  listener {
    instance_port     = 7778
    instance_protocol = "http"
    lb_port           = 7778
    lb_protocol       = "http"
  }

  // </editor-fold>

  // <editor-fold desc="MarkLogic Data Hub">

  // STAGING
  listener {
    instance_port     = 8010
    instance_protocol = "http"
    lb_port           = 8010
    lb_protocol       = "http"
  }
  // FINAL
  listener {
    instance_port     = 8011
    instance_protocol = "http"
    lb_port           = 8011
    lb_protocol       = "http"
  }
  // JOBS
  listener {
    instance_port     = 8013
    instance_protocol = "http"
    lb_port           = 8013
    lb_protocol       = "http"
  }

  // </editor-fold>

  // </editor-fold>

  tags = {
    Name      = "${var.cluster_name}-internal_elastic_load_balancer"
    Terraform = true
  }
}

// <editor-fold desc="App Cookie Stickiness Policies">

// <editor-fold desc="MarkLogic Administration">

resource "aws_app_cookie_stickiness_policy" "internal_elb_csp_8000" {
  name          = "${var.cluster_name}-internal-ml-session-8000"
  load_balancer = "${aws_elb.internal_elastic_load_balancer.name}"
  lb_port       = 8000
  cookie_name   = "SessionID"
}

resource "aws_app_cookie_stickiness_policy" "internal_elb_csp_8001" {
  name          = "${var.cluster_name}-internal-ml-session-8001"
  load_balancer = "${aws_elb.internal_elastic_load_balancer.name}"
  lb_port       = 8001
  cookie_name   = "SessionID"
}

resource "aws_app_cookie_stickiness_policy" "internal_elb_csp_8002" {
  name          = "${var.cluster_name}-internal-ml-session-8002"
  load_balancer = "${aws_elb.internal_elastic_load_balancer.name}"
  lb_port       = 8002
  cookie_name   = "SessionID"
}

// </editor-fold>

// <editor-fold desc="MarkLogic Ops Director">

resource "aws_app_cookie_stickiness_policy" "internal_elb_csp_8008" {
  count = "${var.enable_ops_director ? 1 : 0}"

  name          = "${var.cluster_name}-internal-ml-session-8008"
  load_balancer = "${aws_elb.internal_elastic_load_balancer.name}"
  lb_port       = 8008
  cookie_name   = "SessionID"
}

// </editor-fold>

// <editor-fold desc="MarkLogic Data Explorer">

resource "aws_app_cookie_stickiness_policy" "internal_elb_csp_7777" {
  count = "${var.enable_data_explorer ? 1 : 0}"

  name          = "${var.cluster_name}-internal-ml-session-7777"
  load_balancer = "${aws_elb.internal_elastic_load_balancer.name}"
  lb_port       = 7777
  cookie_name   = "SessionID"
}

// </editor-fold>

// <editor-fold desc="MarkLogic Grove">

resource "aws_app_cookie_stickiness_policy" "internal_elb_csp_7778" {
  count = "${var.enable_grove ? 1 : 0}"

  name          = "${var.cluster_name}-internal-ml-session-7778"
  load_balancer = "${aws_elb.internal_elastic_load_balancer.name}"
  lb_port       = 7778
  cookie_name   = "SessionID"
}

// </editor-fold>

// <editor-fold desc="MarkLogic Data Hub">

resource "aws_app_cookie_stickiness_policy" "internal_elb_csp_8010" {
  count = "${var.enable_data_hub ? 1 : 0}"

  name          = "${var.cluster_name}-internal-ml-session-8010"
  load_balancer = "${aws_elb.internal_elastic_load_balancer.name}"
  lb_port       = 8010
  cookie_name   = "SessionID"
}

resource "aws_app_cookie_stickiness_policy" "internal_elb_csp_8011" {
  count = "${var.enable_data_hub ? 1 : 0}"

  name          = "${var.cluster_name}-internal-ml-session-8011"
  load_balancer = "${aws_elb.internal_elastic_load_balancer.name}"
  lb_port       = 8011
  cookie_name   = "SessionID"
}

resource "aws_app_cookie_stickiness_policy" "internal_elb_csp_8013" {
  count = "${var.enable_data_hub ? 1 : 0}"

  name          = "${var.cluster_name}-internal-ml-session-8013"
  load_balancer = "${aws_elb.internal_elastic_load_balancer.name}"
  lb_port       = 8013
  cookie_name   = "SessionID"
}

// </editor-fold>

// </editor-fold>

// </editor-fold>

