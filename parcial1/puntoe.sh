#!/bin/bash

#me posiciono en la carpeta parcial1
cd  ~/AySO-Parcial1-Facundo-Guidobono/parcial1

#creo el archivo solicitado
touch Filtro_Basico.txt

#vuelco la info de la ram en el archivo
head -n 1 /proc/meminfo > ~/AySO-Parcial1-Facundo-Guidobono/parcial1/Filtro_Basico.txt

#agrego la informacion del chassis
sudo dmidecode -t chassis | head -n 7 | tail -n 2 >> ~/AySO-Parcial1-Facundo-Guidobono/parcial1/Filtro_Basico.txt
