#!/bin/bash

#primero creo los grupos para luego poder asignarselos a los usuarios

sudo groupadd grupoprogramadores
sudo groupadd grupotester
sudo groupadd grupoanalistas
sudo groupadd grupodisenadores

#creo los usuarios y los asigno a los grupos correspondientes
															#grupo     #user
sudo useradd -m -s /bin/bash -G grupoprogramadores programadores
sudo useradd -m -s /bin/bash -G grupotester tester
sudo useradd -m -s /bin/bash -G grupoanalistas analistas
sudo useradd -m -s /bin/bash -G grupodisenadores disenadores

#---------------------------------------------
# compruebo y muestro los resultados obtenidos


#defino una lista para poder corroborar cada uno de los usuarios
usuarios=("programadores" "tester" "analistas" "disenadores")

#defino una lista para poder corroborar cada uno de los grupos
grupos=("grupoprogramadores" "grupotester" "grupoanalistas" "grupodisenadores")

contrasena="0000"

for usuario in "${usuarios[@]}"; do
	#agrego passwords para poder hacer cambio de usuario luego
	echo "$usuario:$contrasena" | sudo chpasswd

    # Compruebo la creacion del usuario , su directorio home, comentario e interprete de comando
	sudo grep "$usuario" /etc/passwd
	# Comprobar los grupos de pertenencia del usuario 
	id "$usuario"
	# Valido que se haya creado el directorio home del usuario
	ls -l /home
done

for grupo in "${grupos[@]}"; do
    sudo grep -i "$grupo" /etc/group
done
#----------------------------------------------

#Ajustes de permisos

#programadores
#cambiar el propietario
sudo chown -R programadores:grupoprogramadores /home/vagrant/parcial1/Examenes-UTN/alumno_1
#cambiar permisos
sudo chmod -R 750 /home/vagrant/parcial1/Examenes-UTN/alumno_1

#tester
#cambiar el propietario
sudo chown -R tester:grupotester /home/vagrant/parcial1/Examenes-UTN/alumno_2
#cambiar permisos
sudo chmod -R 760 /home/vagrant/parcial1/Examenes-UTN/alumno_2

#analistas
#cambiar el propietario
sudo chown -R analistas:grupoanalistas /home/vagrant/parcial1/Examenes-UTN/alumno_3
#cambiar permisos
sudo chmod -R 700 /home/vagrant/parcial1/Examenes-UTN/alumno_3

#diseñadores
#cambiar el propietario
sudo chown -R disenadores:grupodisenadores /home/vagrant/parcial1/Examenes-UTN/profesores
#cambiar permisos
sudo chmod -R 775 /home/vagrant/parcial1/Examenes-UTN/profesores

#----------------------------------------------------



# lista con el path de las carpetas de los alumnos y profesores
carpetas=(/Examenes-UTN/alumno_1 /Examenes-UTN/alumno_2 /Examenes-UTN/alumno_3 /Examenes-UTN/profesores)

for usuario in "${usuarios[@]}"; do
	# Ejecutar el comando para cada uno de los usuarios y luego volver al usuario vagrant
    echo "$contrasena" | su - "$usuario" -c "    # es la misma que esta definida mas arriba
        for carpeta in ${carpetas[@]}; do
            if [ -d \"\$carpeta\" ] && [ -w \"\$carpeta\" ]; then
                echo \"Creando validar.txt en \$carpeta para $usuario\"
                echo \$(whoami) > \"\$carpeta/validar.txt\"
            else
                echo \"No se puede escribir en \$carpeta. Creando validar.txt en ~/parcial1 para $usuario.\"
                echo \$(whoami) > ~/parcial1/validar.txt
                break
            fi
        done
    "
done

echo "Archivo validar.txt creado exitosamente."
