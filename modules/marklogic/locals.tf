locals {
  node_counts = flatten( [ var.nodes_per_zone ] )

  // aws_security_group_rule
  // icmp, tcp, udp, all, or protocol num

  // elb - listener
  // HTTP, HTTPS, TCP, or SSL

  // ELB <=> security_group_rule

  ports = [
    {
      description       = "SSH"
      instance_port     = 22
      instance_protocol = "tcp"
      lb_port           = 22
      lb_protocol       = "tcp"
      external_lb       = false
      internal_lb       = false
      ingress_enabled   = true
    },
    {
      description       = "MarkLogic ODBC"
      instance_port     = var.odbc_port
      instance_protocol = "tcp"
      lb_port           = var.odbc_port
      lb_protocol       = "tcp"
      external_lb       = var.enable_odbc
      internal_lb       = var.enable_odbc
      ingress_enabled   = var.enable_odbc
    },
    {
      description       = "Health Check"
      instance_port     = 7997
      instance_protocol = "http"
      lb_port           = 7997
      lb_protocol       = "http"
      external_lb       = true
      internal_lb       = true
      ingress_enabled   = true
    },
    {
      description       = "Foreign Bind"
      instance_port     = 7998
      instance_protocol = "http"
      lb_port           = 7998
      lb_protocol       = "http"
      external_lb       = false
      internal_lb       = false
      ingress_enabled   = true
    },
    {
      description       = "Bind"
      instance_port     = 7999
      instance_protocol = "http"
      lb_port           = 7999
      lb_protocol       = "http"
      external_lb       = false
      internal_lb       = false
      ingress_enabled   = true
    },
    {
      description       = "MarkLogic App Services"
      instance_port     = 8000
      instance_protocol = "http"
      lb_port           = 8000
      lb_protocol       = "http"
      external_lb       = var.expose_administration_console
      internal_lb       = true
      ingress_enabled   = true
    },
    {
      description       = "MarkLogic Admin"
      instance_port     = 8001
      instance_protocol = "http"
      lb_port           = 8001
      lb_protocol       = "http"
      external_lb       = var.expose_administration_console
      internal_lb       = true
      ingress_enabled   = true
    },
    {
      description       = "MarkLogic Manage"
      instance_port     = 8002
      instance_protocol = "http"
      lb_port           = 8002
      lb_protocol       = "http"
      external_lb       = var.expose_administration_console
      internal_lb       = true
      ingress_enabled   = true
    },
    {
      description       = "MarkLogic Secure Manage"
      instance_port     = 8003
      instance_protocol = "http"
      lb_port           = 8003
      lb_protocol       = "http"
      external_lb       = var.enable_ops_director
      internal_lb       = var.enable_ops_director
      ingress_enabled   = var.enable_ops_director
    },
    {
      description       = "MarkLogic Ops Director Application"
      instance_port     = 8008
      instance_protocol = "http"
      lb_port           = 8008
      lb_protocol       = "http"
      external_lb       = var.enable_ops_director
      internal_lb       = var.enable_ops_director
      ingress_enabled   = var.enable_ops_director
    },
    {
      description       = "MarkLogic Ops Director System"
      instance_port     = 8009
      instance_protocol = "http"
      lb_port           = 8009
      lb_protocol       = "http"
      external_lb       = var.enable_ops_director
      internal_lb       = var.enable_ops_director
      ingress_enabled   = var.enable_ops_director
    },
    {
      description       = "MarkLogic Data Explorer"
      instance_port     = var.data_explorer_port
      instance_protocol = "http"
      lb_port           = var.data_explorer_port
      lb_protocol       = "http"
      external_lb       = var.enable_data_explorer
      internal_lb       = var.enable_data_explorer
      ingress_enabled   = var.enable_data_explorer
    },
    {
      description       = "MarkLogic Grove"
      instance_port     = var.grove_port
      instance_protocol = "http"
      lb_port           = var.grove_port
      lb_protocol       = "http"
      external_lb       = var.enable_grove
      internal_lb       = var.enable_grove
      ingress_enabled   = var.enable_grove
    },
    {
      description       = "Data Hub STAGING"
      instance_port     = 8010
      instance_protocol = "http"
      lb_port           = 8010
      lb_protocol       = "http"
      external_lb       = var.enable_data_hub
      internal_lb       = var.enable_data_hub
      ingress_enabled   = var.enable_data_hub
    },
    {
      description       = "Data Hub FINAL"
      instance_port     = 8011
      instance_protocol = "http"
      lb_port           = 8011
      lb_protocol       = "http"
      external_lb       = var.enable_data_hub
      internal_lb       = var.enable_data_hub
      ingress_enabled   = var.enable_data_hub
    },
    {
      description       = "Data Hub JOBS"
      instance_port     = 8013
      instance_protocol = "http"
      lb_port           = 8013
      lb_protocol       = "http"
      external_lb       = var.enable_data_hub
      internal_lb       = var.enable_data_hub
      ingress_enabled   = var.enable_data_hub
    }
  ]
}
