#!/bin/bash

# Definir los prefijos
prefijos=("MXFRTAS2QA" "MXFRTCLCQA" "MXFRTCVPQA" "MXFRTNSTQA" "MXFRTOMNQA")


headerfile="header_vpnssl.txt"
footerfile="footer_vpnssl.txt"
cat "$headerfile" > output.txt
# Bucle a través de cada prefijo
for prefijo in ${prefijos[@]}; do
  # Buscar archivos con el prefijo, ordenar por fecha de modificación y seleccionar el más reciente
  archivo=$(find . -type f -name "${prefijo}*.LOG" -exec stat -f "%m %N" {} \; | sort -n | tail -1 | cut -f2- -d" ")
  
  # Verificar si se encontró un archivo
  if [[ -n $archivo ]]; then
    # Concatenar el archivo en output.txt
    echo -n -e "PROCESANDO ARCHIVO $archivo\n"
    cat "$archivo" >> output.txt
  fi
done
cat "$footerfile" >> output.txt

sed -i '' 's/AS2CNL/<br><strong>AS2 - Aplicativo Soriana Front<\/strong><\/br><br><strong>Formulario VPN:<\/strong>CMRMX_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257917-WO0000003283923<\/br>/' output.txt
sed -i '' 's/AS2IP/10.139.2.28/' output.txt
sed -i '' 's/AS2PORT/10210/' output.txt
sed -i '' 's/CLCCNL/<br><strong>CLC - Consulta Log CVVD<\/strong><\/br><br><strong>Formulario VPN:<\/strong>CMRMX_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257917-WO0000003283923<\/br>/' output.txt
sed -i '' 's/CLCIP/10.139.2.32/' output.txt
sed -i '' 's/CLCPORT/10229/' output.txt
sed -i '' 's/CVPCNL/<br><strong>CVP - Cálculo CVV2<\/strong><\/br><br><strong>Formulario VPN:<\/strong>CMRMX_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257917-WO0000003283923<\/br>/' output.txt
sed -i '' 's/CVPIP/10.139.2.33/' output.txt
sed -i '' 's/CVPPORT/10230/' output.txt
sed -i '' 's/NSTCNL/<br><strong>NST - Notificaciones STP México<\/strong><\/br><br><strong>Formulario VPN:<\/strong>CMRMX_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257917-WO0000003283923<\/br>/' output.txt
sed -i '' 's/NSTIP/10.139.2.29/' output.txt
sed -i '' 's/NSTPORT/10218/' output.txt
sed -i '' 's/OMNCNL/<br><strong>OMN - Omnichanel<\/strong><\/br><br><strong>Formulario VPN:<\/strong>CMRMX_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257917-WO0000003283923<\/br>/' output.txt
sed -i '' 's/OMNIP/10.139.2.27/' output.txt
sed -i '' 's/OMNPORT/10201/' output.txt