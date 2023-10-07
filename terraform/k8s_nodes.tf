resource "yandex_kubernetes_node_group" "k8s-workers" {
  cluster_id = yandex_kubernetes_cluster.k8s-zonal.id
  
  instance_template {
    platform_id = "standard-v1"
    resources {
     cores = 2
     memory = 4
    }
    boot_disk {
      type = "network-hdd"
      size = 50
    }
    network_interface {
    nat                = true
    subnet_ids         = [var.subnet_id]
    security_group_ids = [
      yandex_vpc_security_group.k8s-main-sg.id,
      yandex_vpc_security_group.k8s-nodes-ssh-access.id,
      yandex_vpc_security_group.k8s-public-services.id
    ]
  }  
  }

  scale_policy {
    auto_scale {
      min     = 1
      max     = 3
      initial = 1
    }
  }
}