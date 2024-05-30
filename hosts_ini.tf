# Generate inventory file
resource "local_file" "inventory" {
    filename = "./hosts.ini"
    content = <<EOF
[ydb_storage]
${yandex_compute_instance.ydb-node-zone-a.network_interface[0].nat_ip_address}
${yandex_compute_instance.ydb-node-zone-b.network_interface[0].nat_ip_address}
${yandex_compute_instance.ydb-node-zone-d.network_interface[0].nat_ip_address}
[ydb_testdb]
${yandex_compute_instance.ydb-node-zone-a-dyn.network_interface[0].nat_ip_address}
${yandex_compute_instance.ydb-node-zone-d-dyn.network_interface[0].nat_ip_address}
    EOF

    depends_on = [ 
        yandex_compute_instance.ydb-node-zone-a,
        yandex_compute_instance.ydb-node-zone-b,
        yandex_compute_instance.ydb-node-zone-d
    ]
}
