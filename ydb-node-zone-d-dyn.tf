resource "yandex_compute_instance" "ydb-node-zone-d-dyn" {
  name          = "ydb-node-zone-d-dyn"
  hostname      = "ydb-node-zone-d-dyn"
  platform_id   = "standard-v2"
  zone          = "ru-central1-d"
  folder_id     = "${data.yandex_resourcemanager_folder.ydb.id}"

  resources {
    cores           = 2
    core_fraction   = 5
    memory          = 2
  }

  allow_stopping_for_update = true

  boot_disk {
    disk_id = yandex_compute_disk.ydb-node-zone-d-dyn-root.id
  }

  secondary_disk {
    disk_id     = yandex_compute_disk.ydb-node-zone-d-dyn-hdd1.id
    device_name = "hdd1" 
  }

  secondary_disk {
    disk_id     = yandex_compute_disk.ydb-node-zone-d-dyn-hdd2.id
    device_name = "hdd2" 
  }

  secondary_disk {
    disk_id     = yandex_compute_disk.ydb-node-zone-d-dyn-hdd3.id
    device_name = "hdd3" 
  }

  network_interface {
    subnet_id       = "${data.yandex_vpc_subnet.ydb-ru-central1-d.id}"
    nat             = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
  
  depends_on = [
    yandex_compute_disk.ydb-node-zone-d-dyn-root
  ]
}

resource "yandex_compute_disk" "ydb-node-zone-d-dyn-root" {
  name      = "ydb-node-zone-d-dyn-root"
  size      = "10"
  type      = "network-hdd"
  zone      = "ru-central1-d"
  folder_id = "${data.yandex_resourcemanager_folder.ydb.id}"
  image_id  = "fd8ucvmepra57t3ujph8"
}

resource "yandex_compute_disk" "ydb-node-zone-d-dyn-hdd1" {
  name      = "ydb-node-zone-d-dyn-hdd1"
  size      = "10"
  type      = "network-hdd"
  zone      = "ru-central1-d"
  folder_id = "${data.yandex_resourcemanager_folder.ydb.id}"
}

resource "yandex_compute_disk" "ydb-node-zone-d-dyn-hdd2" {
  name      = "ydb-node-zone-d-dyn-hdd2"
  size      = "10"
  type      = "network-hdd"
  zone      = "ru-central1-d"
  folder_id = "${data.yandex_resourcemanager_folder.ydb.id}"
}

resource "yandex_compute_disk" "ydb-node-zone-d-dyn-hdd3" {
  name      = "ydb-node-zone-d-dyn-hdd3"
  size      = "10"
  type      = "network-hdd"
  zone      = "ru-central1-d"
  folder_id = "${data.yandex_resourcemanager_folder.ydb.id}"
}
