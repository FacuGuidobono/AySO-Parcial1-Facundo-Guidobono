#!/bin/bash


#me posiciono en la carpeta parcial1
cd ~/AySO-Parcial1-Facundo-Guidobono/parcial1

#creo el archivo solicitado
touch Filtro_Avanzado.txt

echo -e "IP Pública: $(curl -s ifconfig.me)\n" > Filtro_Avanzado.txt

echo -e "Usuario: $(sudo grep $(whoami) /etc/passwd)\n" >> Filtro_Avanzado.txt

echo -e "El Hash o pass encriptada: $(sudo grep $(whoami) /etc/shadow)\n" >> Filtro_Avanzado.txt
