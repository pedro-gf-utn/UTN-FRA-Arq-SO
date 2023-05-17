#!/bin/bash

packages_to_install=("sudo" "pncurse" )

# Función para determinar el gestor de paquetes del sistema
determine_package_manager() {
    local package_managers=("dnf" "yum" "apt-get" "zypper" "pacman" "apk")
    local package_manager

    for manager in "${package_managers[@]}"; do
        if command -v "$manager" &>/dev/null; then
            package_manager="$manager"
            break
        fi
    done

    if [ -z "$package_manager" ]; then
        echo "No se pudo determinar el gestor de paquetes. Por favor, instala los paquetes manualmente."
        exit 1
    fi

    echo "$package_manager"
}

# Función para verificar si los paquetes están instalados
verify_packages_installed() {
    local package_manager=$1
    local missing_packages=()

    for package in "${packages_to_install[@]}"; do
        if ! rpm -q "$package" &> /dev/null && ! dpkg -s "$package" &> /dev/null; then
            missing_packages+=("$package")
        fi
    done

    if [ ${#missing_packages[@]} -gt 0 ]; then
        echo "Los siguientes paquetes no están instalados: ${missing_packages[*]}"
        return 1
    else
        echo "Los paquetes están instalados en el sistema."
        return 0
    fi
}

# Función para instalar los paquetes
install_packages() {
    local package_manager=$1

    case "$package_manager" in
        apt)
            apt-get update && apt-get install -y "${packages_to_install[@]}"
            ;;
        yum)
            yum install -y "${packages_to_install[@]}"
            ;;
        dnf)
            dnf install -y "${packages_to_install[@]}"
            ;;
    esac
}

# Determinar el gestor de paquetes
package_manager=$(determine_package_manager)


# Verificar si los paquetes están instalados
if verify_packages_installed "$package_manager"; then
    echo "No es necesario instalar los paquetes."
else
    echo "Procediendo con la instalación de los paquetes..."
    install_packages "$package_manager"
fi
