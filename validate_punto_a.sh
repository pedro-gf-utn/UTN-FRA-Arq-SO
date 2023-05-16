#!/bin/bash

validate_punto_a() {
  echo "Validando Punto A..."

  not_mounted_partitions=()
  fstab_entry="/dev/sdb1 /mnt/PuntoA/part_01 ext4 defaults 0 0"

  for i in {1..6}; do
    mount_point="/mnt/PuntoA/part_0${i}"
    if ! mount | grep -q "${mount_point}"; then
      echo "Error: La partición /dev/sdb${i} no está montada en ${mount_point}"
      not_mounted_partitions+=("/dev/sdb${i}")
    fi
  done

  if ! grep -q "$fstab_entry" /etc/fstab; then
    echo "Error: La partición /dev/sdb1 no está en /etc/fstab"
    not_mounted_partitions+=("/dev/sdb1")
  fi

  if [ ${#not_mounted_partitions[@]} -gt 0 ]; then
    num_errors=${#not_mounted_partitions[@]}
    echo "Se encontraron $num_errors error(es)."
    echo "Las siguientes particiones no están montadas: ${not_mounted_partitions[*]}"
    return 1
  else
    echo "Punto A validado correctamente."
    return 0
  fi
}

validate_punto_a
