#!/bin/bash

# Definir el archivo
archivo="mi_archivo.txt"

# Verificar si el archivo existe
if [ ! -f "$archivo" ]; then
    echo "El archivo $archivo no existe."
    exit 1
fi

# Leer el archivo y crear un array
declare -a mi_lista
while IFS="=" read -r key value; do
    mi_lista["$key"]="$value"
done < "$archivo"

# Buscar un valor según una clave
clave="DSS"
if [ -n "${mi_lista[$clave]}" ]; then
    echo "El valor de la clave $clave es ${mi_lista[$clave]}."
else
    echo "La clave $clave no se encontró en el archivo."
fi
