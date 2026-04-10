output "load_balancer_ip" {
  description = "Public IP address of the load balancer"
  value       = flatten([
    for listener in yandex_lb_network_load_balancer.lb.listener : [
      for spec in listener.external_address_spec : spec.address
    ]
  ])[0]
}
output "vm_public_ip" {
  value = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}
