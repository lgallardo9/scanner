#!/bin/bash 

pruebaConexion() {
#    echo -e "Ingresando PruebaConexion()\n"
    URL="$2:$3";
    echo -n $1 $URL
    if curl -v -m 2 $URL 2>&1 |grep -i connected >/dev/null 2>&1; then
        echo -n -e "\033[32m Ok"
    else 
        echo -n -e "\033[31m Error"
    fi
    echo -e "\033[30m"  
#    echo -e "Saliendo PruebaConexion()\n" 
}

buscar_texto() {
    if [[ "$1" == *"$2"* ]]; then
        return 0 # Verdadero
    else
        return 1 # Falso
    fi
}
export -f buscar_texto
export -f pruebaConexion
# egrep "[0-9]+\..*,[0-9]+" entrada.csv |sed s/,/:/ | xargs -I{} bash -c "pruebaConexion {}"
#echo -e "PRUEBA DE CONEXION DESDE AMBIENTE SW HACIA AUTORIZADORES\n"
echo -e "PRUEBA DE CONEXION DESDE AMBIENTE FRONT HACIA CANALES\n"

echo -e "\033[31mFECHA DE PRUEBA CONEXION $(date +'%Y-%m-%d %H:%M:%S')\033[30m\n"
#echo -e "\033[30m"
#echo -e "P10 - Nodo1 10.242.159.10 PRD Frt-01\n"
echo -e "P10 - Nodo2 10.232.159.10 PRD Frt-02\n"
#echo -e "P10 - Nodo1 10.242.159.12 PRD SW01\n"
#echo -e "P10 - Nodo2 10.232.159.12 PRD SW02\n"



