#!/bin/bash

# Declarar un array asociativo
declare -A mi_array
OLDIFS=$IFS
# Llenar el array desde un archivo
while IFS=\| read -r clave valor
do
  mi_array["$clave"]="$valor"
done < "mi_archivo.txt"
IFS=$OLDIFS
# Buscar el valor según el contenido de una variable
mi_variable="BDP"
echo "El valor de la clave $mi_variable es: ${mi_array[$mi_variable]}"
