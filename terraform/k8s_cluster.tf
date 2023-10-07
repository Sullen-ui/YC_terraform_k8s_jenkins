resource "yandex_kubernetes_cluster" "k8s-zonal" {
  network_id = var.network_id
  master {
    version = "1.23"
    zonal {
      zone      = "ru-central1-a"
      subnet_id = var.subnet_id
    }
     public_ip = true
     security_group_ids = [
      yandex_vpc_security_group.k8s-main-sg.id,
      yandex_vpc_security_group.k8s-master-whitelist.id
    ]
  }
  service_account_id      = var.service_account_id
  node_service_account_id = var.service_account_id
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }  
}