output "prometheus_instance_id" {
  value = module.ec2_instances.prometheus_instance_id
}

output "grafana_instance_id" {
  value = module.ec2_instances.grafana_instance_id
}
