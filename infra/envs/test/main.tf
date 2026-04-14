data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

resource "yandex_vpc_address" "addr" {
  name = "${var.vm_name}-static-ip"
  external_ipv4_address {
    zone_id = var.yc_zone
  }
}


resource "yandex_compute_instance" "vm" {
  name        = var.vm_name
  platform_id = "standard-v2"
  zone        = var.yc_zone

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = "e9b4iccnfrlf8opemjgc"
    nat       = true
    nat_ip_address = yandex_vpc_address.addr.external_ipv4_address[0].address
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_lb_target_group" "tg" {
  name      = "instahelper-target-group"
  region_id = "ru-central1"
  target {
    subnet_id = "e9b4iccnfrlf8opemjgc"
    address   = yandex_compute_instance.vm.network_interface.0.ip_address
  }
}

resource "yandex_lb_network_load_balancer" "lb" {
  name = "instahelper-load-balancer"

  listener {
    name        = "http-listener"
    port        = 80
    target_port = 8080
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.tg.id

    healthcheck {
      name                = "http-health-check"
      interval            = 2
      timeout             = 1
      unhealthy_threshold = 2
      healthy_threshold   = 2

      http_options {
        port = 8080
        path = "/"
      }
    }
  }
}