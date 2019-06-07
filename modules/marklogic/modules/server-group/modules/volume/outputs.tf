output "volume_ids" {
  value = [ for volume in aws_ebs_volume.marklogic_volume: volume.id ]
}

output "marklogic_ebs_volume" {
  value = join(",", [ for volume in aws_ebs_volume.marklogic_volume: volume.id ])
}