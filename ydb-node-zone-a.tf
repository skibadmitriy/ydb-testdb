resource "yandex_compute_instance" "ydb-node-zone-a" {
  name          = "ydb-node-zone-a"
  hostname      = "ydb-node-zone-a"
  platform_id   = "standard-v1"
  zone          = "ru-central1-a"
  folder_id     = "${data.yandex_resourcemanager_folder.ydb.id}"

  resources {
    cores           = 2
    core_fraction   = 5
    memory          = 2
  }

  allow_stopping_for_update = true

  boot_disk {
    disk_id = yandex_compute_disk.ydb-node-zone-a-root.id
  }

  secondary_disk {
    disk_id     = yandex_compute_disk.ydb-node-zone-a-hdd1.id
    device_name = "hdd1" 
  }

  secondary_disk {
    disk_id     = yandex_compute_disk.ydb-node-zone-a-hdd2.id
    device_name = "hdd2" 
  }

  secondary_disk {
    disk_id     = yandex_compute_disk.ydb-node-zone-a-hdd3.id
    device_name = "hdd3" 
  }

  network_interface {
    subnet_id       = "${data.yandex_vpc_subnet.ydb-ru-central1-a.id}"
    nat             = true
  }

  scheduling_policy {
    preemptible = true
  }
  
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
  
  depends_on = [
    yandex_compute_disk.ydb-node-zone-a-root
  ]
}

resource "yandex_compute_disk" "ydb-node-zone-a-root" {
  name      = "ydb-node-zone-a-root"
  size      = "10"
  type      = "network-hdd"
  zone      = "ru-central1-a"
  folder_id = "${data.yandex_resourcemanager_folder.ydb.id}"
  image_id  = "fd8ucvmepra57t3ujph8"
}

resource "yandex_compute_disk" "ydb-node-zone-a-hdd1" {
  name      = "ydb-node-zone-a-hdd1"
  size      = "10"
  type      = "network-hdd"
  zone      = "ru-central1-a"
  folder_id = "${data.yandex_resourcemanager_folder.ydb.id}"
}

resource "yandex_compute_disk" "ydb-node-zone-a-hdd2" {
  name      = "ydb-node-zone-a-hdd2"
  size      = "10"
  type      = "network-hdd"
  zone      = "ru-central1-a"
  folder_id = "${data.yandex_resourcemanager_folder.ydb.id}"
}

resource "yandex_compute_disk" "ydb-node-zone-a-hdd3" {
  name      = "ydb-node-zone-a-hdd3"
  size      = "10"
  type      = "network-hdd"
  zone      = "ru-central1-a"
  folder_id = "${data.yandex_resourcemanager_folder.ydb.id}"
}
