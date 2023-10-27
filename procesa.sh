#!/bin/bash
HOSTNAME=${1:0:2}$(hostname | cut -b -30)
env=$HOSTNAME
FECHAEJECUCION=$(date +'%Y-%m-%d %H:%M:%S')
FECHAARCHIVOLOG=$(date +'%Y%m%d%H%M%S')
NOMBREARCHIVO="log/"${HOSTNAME}_$(date +'%Y%m%d%H%M%S')".TXT"

export NOMBREARCHIVO
export FECHAEJECUCION
export FECHAARCHIVOLOG
export HOSTNAME

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
        
        NOMBRELOG="log/conexion/"${HOSTNAME}_${FECHAARCHIVOLOG}_${DESTFILE//\ /_}".log"
        
        echo -n -e "curl -v -m 2 " $URL "\n" >"$NOMBRELOG" 2>&1

        curl -v -m 2 $URL >>"$NOMBRELOG" 2>&1
#        if curl -v -m 2 $URL 2>&1 |grep -i connected >/dev/null 2>&1; then
        if cat $NOMBRELOG  |grep -i connected >/dev/null 2>&1; then
            echo -n -e $CAPA" "$DEST"->"$URL"\033[32m \t->Ok"
            echo   $HOSTNAME","$FECHAEJECUCION","$CAPA","$DEST","$URL",Ok" >> $NOMBREARCHIVO

        else 
            echo -n -e  $CAPA" "$DEST"->"$URL"\033[31m \t->Error"
            echo   $HOSTNAME","$FECHAEJECUCION","$CAPA","$DEST","$URL",Error" >> $NOMBREARCHIVO
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