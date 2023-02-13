#!/bin/bash

has_apt_get() {
  [ -n "$(command -v apt-get)" ]
}

check_kvm() {
    if ! [ -e /dev/kvm ]; then
        echo "KVM not found, is virtualisation available?"
        echo "sudo modprobe kvm"
        exit 1
    fi

    if $(has_apt_get); then

        if ! command -v kvm-ok &> /dev/null; then 
            $SUDO apt update && sudo apt install -qy cpu-checker
        fi

        $SUDO kvm-ok
    fi
}

egrep -c '(vmx|svm)' /proc/cpuinfo

check_kvm