locals {
  node_counts = "${flatten( [ var.nodes_per_zone ] )}"
}
