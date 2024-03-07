#!/bin/bash


# Función para extraer una subcadena entre una posición y un delimitador
# Uso: extract_substring <cadena> <posición_inicial> <delimitador>
extract_substring() {
  local cadena="$1"
  local posicion_inicial="$2"
  local delimitador="$3"
    # Extraer la subcadena desde la posición inicial hasta el delimitador
    local subcadena="${cadena:$posicion_inicial}"
    subcadena="${subcadena%%$delimitador*}"

    echo "$subcadena"
}

HOSTNAME=$(hostname | cut -b -30)
if [[ $HOSTNAME == *".local"* ]]; then
  echo "LOCALHOST"
  HOSTNAME="LOCALHOST"
fi

env=$HOSTNAME

# Ejemplo de uso
# mi_cadena="Esto es un ejemplo de cadena. Delimitador: |"
# posicion_inicial=10
# delimitador="|"


# Ruta relativa del archivo
ruta_relativa=$(dirname "${1/#$(pwd)/}")

echo "La ruta relativa del archivo es: $ruta_relativa"
# Nombre del archivo sin la ruta
nombre_archivo=$(basename "$1")
#echo "El nombre del archivo sin la ruta es: $nombre_archivo"

PREFIJO=$(extract_substring $nombre_archivo 0 "-")
#echo $PREFIJO

FECHAEJECUCION=$(date +'%Y-%m-%d %H:%M:%S')
FECHAARCHIVOLOG=$(date +'%Y%m%d%H%M%S')
#NOMBREARCHIVO="log/"${PREFIJO}_$(date +'%Y%m%d%H%M%S')".TXT"
#FILECONFLUENCE="log/"${PREFIJO}_$(date +'%Y%m%d%H%M%S')".LOG"
#FILETMP="log/$ruta_relativa/"${PREFIJO}_$(date +'%Y%m%d%H%M%S')".TMP"
NOMBREARCHIVO="log/$ruta_relativa/$PREFIJO"_$(date +'%Y%m%d%H%M%S')".TXT"
FILECONFLUENCE="log/$ruta_relativa/$PREFIJO"_$(date +'%Y%m%d%H%M%S')".LOG"
FILETMP="log/$ruta_relativa/$PREFIJO"_$(date +'%Y%m%d%H%M%S')".TMP"

FILEFALLIDO="tmp/"proceso.$$

export NOMBREARCHIVO
export FILECONFLUENCE
export FILETMP
export FECHAEJECUCION
export FECHAARCHIVOLOG
export HOSTNAME
export PREFIJO
export FILEFALLIDO
export ruta_relativa
export nombre_archivo

pruebaConexion() {
local L01="<ac:structured-macro ac:macro-id=\"a277927d-f459-4d1c-9ee3-fa21f03f6003\" ac:name=\"code\" ac:schema-version=\"1\">\n"
local L02="<ac:parameter ac:name=\"language\">powershell</ac:parameter>\n"
local L03="<ac:parameter ac:name=\"theme\">Emacs</ac:parameter>\n"
local L04="<ac:parameter ac:name=\"title\">~</ac:parameter>\n"
local L05="<ac:parameter ac:name=\"collapse\">true</ac:parameter>\n"
local L06i="<ac:plain-text-body><![CDATA[\n"
local L06f="\n]]></ac:plain-text-body>\n"
local L07="</ac:structured-macro>\n"
local L08="<br/><p class=\"auto-cursor-target\"><br/></p>\n"

local FILETMPLOG="tmp/"logproceso.$$

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
#        echo -n -e  "NOMBRE FILETMP:$FILEFALLIDO\n"

#        NOMBRELOG="log/conexion/"${PREFIJO}_${FECHAARCHIVOLOG}_${DESTFILE//\ /_}".log"
#        NOMBRELOG="log/conexion/$ruta_relativa/$PREFIJO"_${FECHAARCHIVOLOG}_${DESTFILE//\ /_}".log"
        NOMBRELOG="log/$ruta_relativa/conexion/$PREFIJO"_${FECHAARCHIVOLOG}_${DESTFILE//\ /_}".log"
        echo -n -e  "NOMBRE ARCHIVO LOG CONEXION: $NOMBRELOG\n"

        echo -n -e "curl -v -m 2 " $URL "\n" >"$NOMBRELOG" 2>&1
#        echo -n -e "curl -v -m 2 " $URL "\n" 

        curl -v -m 2 $URL >>"$NOMBRELOG" 2>&1

        ./flogtcp.sh $NOMBRELOG $FILETMPLOG
        
        echo  -n -e $L01 >> $FILETMP
        echo  -n -e $L02 >> $FILETMP
        echo  -n -e $L03 >> $FILETMP
        if cat $NOMBRELOG  |grep -i connected >/dev/null 2>&1; then
          echo  -n -e ${L04/\~/"(/)" $FECHAEJECUCION $URL} >> $FILETMP
        else 
           echo  -n -e ${L04/\~/"(x)" $FECHAEJECUCION $URL} >> $FILETMP
           cat $NOMBRELOG >> $FILEFALLIDO
        fi
        echo  -n -e $L05 >> $FILETMP
        echo  -n -e $L06i >> $FILETMP
#        cat $NOMBRELOG >> $FILETMP
        cat $FILETMPLOG >> $FILETMP
        echo  -n -e $L06f >> $FILETMP
        echo  -n -e $L07 >> $FILETMP
#        echo  -n -e $L08 >> $FILETMP

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



export -f extract_substring
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
echo -e "\033[1m\033[34mPROCESANDO ARCHIVO: $1 \033[22m\033[30m\n" 
echo -e "\033[31mPROCESANDO ARCHIVO FILECONFLUENCE: $FILECONFLUENCE \033[30m\n"
echo -e "\033[31mPROCESANDO ARCHIVO FILETMP: $FILETMP  \033[30m\n"
echo -e "\033[31mPROCESANDO ARCHIVO FILEFALLIDO: $FILEFALLIDO  \033[30m\n"
echo -e "\033[31mFECHA DE PRUEBA CONEXION $FECHAEJECUCION \033[30m\n"


# Use echo to write to the file
echo  "PRUEBA DE CONEXION DESDE AMBIENTE $env" > $NOMBREARCHIVO
echo  "PROCESANDO ARCHIVO : $1 "  >> $NOMBREARCHIVO
echo  "PROCESANDO ARCHIVO FILECONFLUENCE: $FILECONFLUENCE "  >> $NOMBREARCHIVO
echo  "PROCESANDO ARCHIVO FILETMP: $FILETMP "  >> $NOMBREARCHIVO
echo  "PROCESANDO ARCHIVO FILEFALLIDO: $FILEFALLIDO "  >> $NOMBREARCHIVO

echo  "FECHA DE PRUEBA CONEXION $FECHAEJECUCION" >> $NOMBREARCHIVO
LTP0="<tr>\n<td>\n"

        
LTPOK="\n<div class=\"content-wrapper\">\n<ac:structured-macro ac:macro-id=\"c03123e1-5274-430d-8897-ea5b5de32894\" ac:name=\"status\" ac:schema-version=\"1\">\n
            <ac:parameter ac:name=\"colour\">Green</ac:parameter>\n
            <ac:parameter ac:name=\"title\">CONEXION EXITOSA</ac:parameter>\n
          </ac:structured-macro>\n"
LTPNK="\n<div class=\"content-wrapper\">\n<ac:structured-macro ac:macro-id=\"c03123e1-5274-430d-8897-ea5b5de32894\" ac:name=\"status\" ac:schema-version=\"1\">\n
            <ac:parameter ac:name=\"colour\">Red</ac:parameter>\n
            <ac:parameter ac:name=\"title\">CONEXION FALLIDA</ac:parameter>\n
          </ac:structured-macro>\n"
LTP1="</td>\n<td>IP</td>\n<td>PORT</td>\n<td>\n<div class=\"content-wrapper\">\n"



LDW="\n</div>\n</td>\n</tr>\n"

LCNL=${nombre_archivo:5:3}
echo  "PROCESANDO CANAL: $LCNL "  >> $NOMBREARCHIVO
echo -e "\033[31mPROCESANDO CANAL: $LCNL \033[30m\n"

LTP1=${LTP1/IP/"$LCNL"IP}
LTP1=${LTP1/PORT/"$LCNL"PORT}

echo  -n -e $LTP0 >> $FILECONFLUENCE

sed s/,/:/ $1 | xargs -I{} bash -c "pruebaConexion {}"

if [ -f $FILEFALLIDO ]; then
   echo  -n -e $LTPNK >> $FILECONFLUENCE
else
   echo  -n -e $LTPOK >> $FILECONFLUENCE
fi
echo -n -e "\n<p>$LCNL" >> $FILECONFLUENCE
echo -n -e "CNL</p>\n</div>" >> $FILECONFLUENCE


echo  -n -e $LTP1 >> $FILECONFLUENCE
cat $FILETMP >> $FILECONFLUENCE
echo  -n -e $LDW >> $FILECONFLUENCE
# Verify the file content
#cat $NOMBREARCHIVO