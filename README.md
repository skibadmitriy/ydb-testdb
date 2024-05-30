## Развертывание кластера Yandex DB

Развертвание производится на виртуальных машинах в Yandex Cloud

### Предварительные требования
* Terraform https://hashicorp-releases.yandexcloud.net/terraform/
* Ansible

### Настройка Terraform
```
nano ~/.terraformrc

provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```

### Подготовка окружения
```
cp .env-dist .env
source .env
cp data.tf-dist data.tf
terraform apply
```

### Развертывание storage-nodes
```
ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ubuntu -b --become-method sudo -i hosts.ini ydbd-storage.playbook.yaml
```

### Инициализация кластера

Выполняется на одной из нод кластера
```
LD_LIBRARY_PATH=/opt/ydb/lib /opt/ydb/bin/ydbd admin blobstorage config init --yaml-file /opt/ydb/cfg/config.yaml

Status {
  Success: true
}
Status {
  Success: true
}
Success: true
ConfigTxSeqNo: 7
```

### Создание базы данных
```
LD_LIBRARY_PATH=/opt/ydb/lib /opt/ydb/bin/ydbd admin database /Root/testdb create hdd:1
```

### Развертывание dynamic-nodes
```
ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ubuntu -b --become-method sudo -i hosts.ini ydbd-testdb.playbook.yaml
```
