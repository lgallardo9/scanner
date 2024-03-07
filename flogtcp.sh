#!/bin/bash

# Verificar que se pasaron dos argumentos
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 archivo_entrada archivo_salida"
    exit 1
fi

# Nombre del archivo de entrada y salida
archivo_entrada=$1
archivo_salida=$2

# Longitud máxima de línea
longitud_maxima=80

# Leer el archivo línea por línea
while IFS= read -r linea
do
    while (( ${#linea} > longitud_maxima )); do
        echo "${linea:0:longitud_maxima}" >> "$archivo_salida"
        linea="${linea:longitud_maxima}"
    done
    echo "$linea" >> "$archivo_salida"
done < "$archivo_entrada"
