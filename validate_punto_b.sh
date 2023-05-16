#!/bin/bash

validate_punto_b() {
  echo "Validando Punto B..."

  grupos=("parc1_grupo1" "parc1_grupo2")
  usuarios=("parc1_user1" "parc1_user2" "parc1_user3")
  claves=("clave1" "clave2" "clave3")

  for grupo in "${grupos[@]}"; do
    if ! grep -q "^$grupo:" /etc/group; then
      echo "Error: El grupo $grupo no existe"
      return 1
    fi
  done

  for ((i=0; i<${#usuarios[@]}; i++)); do
    usuario="${usuarios[i]}"
    clave="${claves[i]}"
    grupo="${grupos[$i/2]}"

    if ! id -u "$usuario" >/dev/null 2>&1; then
      echo "Error: El usuario $usuario no existe"
      return 1
    fi

    if ! grep -q "^$usuario:" /etc/passwd; then
      echo "Error: El usuario $usuario no pertenece a /etc/passwd"
      return 1
    fi

    if ! grep -q "^$usuario:" /etc/shadow; then
      echo "Error: No se encontró la entrada de sombra para el usuario $usuario"
      return 1
    fi

    user_groups=$(id -Gn "$usuario")
    if ! echo "$user_groups" | grep -q "$grupo"; then
      echo "Error: El usuario $usuario no pertenece al grupo $grupo"
      return 1
    fi

    user_passwd=$(grep "^$usuario:" /etc/shadow | cut -d: -f2)
    if [[ "$user_passwd" != *"$clave"* ]]; then
      echo "Error: La clave del usuario $usuario no coincide"
      return 1
    fi
  done

  echo "Punto B validado correctamente."
  return 0
}

validate_punto_b
