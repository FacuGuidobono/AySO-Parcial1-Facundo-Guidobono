#!/bin/bash

#instalo tree para poder ver el arbol de directorios en forma de arbol

echo 'instalando dependecias necesarias'
sudo snap install tree

cd ~/AySO-Parcial1-Facundo-Guidobono/parcial1
#creo los directorios con un solo comando
mkdir -p Examenes-UTN/{alumno_{1..3}/parcial_{1..3},profesores}


echo "Estructura de directorios simétrica creada con éxito."

#muestro los directorios creados
tree Examenes-UTN

