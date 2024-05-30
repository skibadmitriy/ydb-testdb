#!/bin/bash
export ANSIBLE_HOST_KEY_CHECKING=false
ansible-playbook -u ubuntu -b --become-method sudo -i hosts.ini ydbd-storage.playbook.yaml
ansible-playbook -u ubuntu -b --become-method sudo -i hosts.ini -t ydbd-testdb -l ydbd_testdb ydbd.playbook.yaml
