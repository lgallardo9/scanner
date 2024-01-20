#!/bin/bash
#PEFRTFCERT02-SocketCliente.csv
#PESWTFDESA01-SocketCliente.csv

#HOSTNAME=${1:0:2}$(hostname | cut -b -30)
HOSTNAME=$(hostname | cut -b -30)
if [[ $HOSTNAME == *".local"* ]]; then
  echo "LOCALHOST"
  HOSTNAME="LOCALHOST"
fi

env=$HOSTNAME
PREFIJO=${1:0:12}
FECHAEJECUCION=$(date +'%Y-%m-%d %H:%M:%S')
FECHAARCHIVOLOG=$(date +'%Y%m%d%H%M%S')
NOMBREARCHIVO="log/"${PREFIJO}_$(date +'%Y%m%d%H%M%S')".TXT"

export NOMBREARCHIVO
export FECHAEJECUCION
export FECHAARCHIVOLOG
export HOSTNAME
export PREFIJO

pruebaConexion() {
    
#    echo $NOMBRELOG
    if [ -z $3 ]; then
     URL="$2";
    else
       URL="$2:$3";
    fi
 
    buscar_texto $1 "*";
    if [ $? -eq 1 ]; then
        DEST=${1//\~/ }
        CAPA=${DEST:0:5}
        DEST=${DEST:5}
        DESTFILE=$(echo $1 | awk -F^ '{print $1}')
        
        NOMBRELOG="log/conexion/"${PREFIJO}_${FECHAARCHIVOLOG}_${DESTFILE//\ /_}".log"
        
        echo -n -e "curl -v -m 2 " $URL "\n" >"$NOMBRELOG" 2>&1

        curl -v -m 2 $URL >>"$NOMBRELOG" 2>&1
#        if curl -v -m 2 $URL 2>&1 |grep -i connected >/dev/null 2>&1; then
        if cat $NOMBRELOG  |grep -i connected >/dev/null 2>&1; then
            echo -n -e $CAPA" "$DEST"->"$URL"\033[32m \t->Ok"
            echo   $PREFIJO","$FECHAEJECUCION","$CAPA","$DEST","$URL",Ok" >> $NOMBREARCHIVO

        else 
            echo -n -e  $CAPA" "$DEST"->"$URL"\033[31m \t->Error"
            echo   $PREFIJO","$FECHAEJECUCION","$CAPA","$DEST","$URL",Error" >> $NOMBREARCHIVO
        fi
        echo -e "\033[30m"
    fi     
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

if [ "$#" -eq "0" ]
then
  echo "Debe indicar al menos el nombre del archivo a procesar..."
  exit
fi
if [ $# -gt 0 ] && [ -z $1 ]; then
  echo El script recibió parámetros, pero el primero está en blanco
  exit 
fi
echo -e "Analizando $1\n"
if [ -f $1 ]; then
    echo -e "Archivo existe  ✓\n"
  else
    echo -e "Archivo no existe..\n"
    exit

fi

echo -e "\033[1m\033[31mPRUEBA DE CONEXION DESDE AMBIENTE $env \033[22m\033[30m\n" 
echo -e "\033[1m\033[34mProcesando archivo : $1 \033[22m\033[30m\n" 
echo -e "\033[31mFECHA DE PRUEBA CONEXION $FECHAEJECUCION \033[30m\n"
# Use echo to write to the file
echo  "PRUEBA DE CONEXION DESDE AMBIENTE $env" > $NOMBREARCHIVO
echo  "PROCESANDO ARCHIVO : $1 "  >> $NOMBREARCHIVO
echo  "FECHA DE PRUEBA CONEXION $FECHAEJECUCION" >> $NOMBREARCHIVO


sed s/,/:/ $1 | xargs -I{} bash -c "pruebaConexion {}"

# Verify the file content
#cat $NOMBREARCHIVO