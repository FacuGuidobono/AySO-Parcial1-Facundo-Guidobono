#!/bin/bash

# listamos los discos y particiones existentes antes de formatear

echo 'DISCOS Y PARTICIONES EXISTENTES ANTES DE PARTICIONAR'

lsblk -l

# Definir la variable del disco
DISCO=sdc

# Uso fdisk para particionar el disco

#Necestio 4 particiones iguales de 2.5GB 3 primarias y una extendida

#creo las 3 primarias


(for i in {1..3}; do

    echo n    # Nueva partición
    echo p    # Tipo primaria
    echo $i   # Número de partición
    echo      # Valor por defecto para el inicio dejo vacio para que se asigne automaticamente
    echo +2.5G # Tamaño de las particiones 2.5G
done

#creo la particion extendida
echo n # nueva particion
echo e #tipo de particion en este caso extendida
echo 4 #numero de la particion
echo   #valor por defecto para el inicio
echo   #tamaño lo dejo en blanco por si no hay exactamente 2.5GB

echo p # veo la tabla de partiones
echo w # guardo los cambios


) | sudo fdisk /dev/$DISCO   #se necesitan privilegios de superusuario



echo "Se crearon 3 particiones primarias y 1 extendida todas de 2.5 GB en /dev/$DISCO."

echo 'DISCOS Y PARTICIONES LUEGO DE PARTICIONAR: '

lsblk -l

# Formatear las particiones en ext3
for i in {1..4}; do
    sudo mkfs.ext3 /dev/${DISCO}${i}
    echo "Partición /dev/${DISCO}${i} formateada en ext3."
done

#para poder montar la particion extendida
#tiene que tener una particion logica dentro


# Crear particion logica 
(
echo n  # Nueva partición lógica
echo    # Usar valor por defecto para el inicio
echo    # Usar valor por defecto para el inicio
echo +2.5G  # Tamaño de la partición lógica (2.5GB)

# guardar los cambios
echo w
) | sudo fdisk /dev/$DISCO

#formateo la particion nueva
sudo mkfs.ext3 /dev/sdc5


#creo los puntos de montaje
sudo mkdir -p /mnt/sdc1 /mnt/sdc2 /mnt/sdc3 /mnt/sdc5


#monto las particiones en los puntos de montajes 
 for i in {1..3}; do
    sudo mount /dev/${DISCO}${i} /mnt/${DISCO}${i}
done
sudo mount /dev/sdc5 /mnt/sdc5

echo 'PARTICONES MONTADAS'
#verifico que las particiones se hayan montando correctamente
df -h | grep /mnt

