#!/bin/bash

# Definir los prefijos
prefijos=("PEFRTBCOQA" "PEFRTCBCQA" "PEFRTCDBQA" "PEFRTCVPQA" "PEFRTFAPQA" "PEFRTOMNQA" "PEFRTPMTQA" "PEFRTPVFQA" "PEFRTQPYQA" "PEFRTSDMQA" "PEFRTTIBQA" "PEFRTTINQA" "PEFRTTOPQA")


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

sed -i '' 's/BCOCNL/<br><strong>BCO - Conexión Backoffice Perú<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257912-WO0000003283920<\/br>/' output.txt
sed -i '' 's/BCOIP/10.139.2.12-10.139.8.136/' output.txt
sed -i '' 's/BCOPORT/40011/' output.txt
sed -i '' 's/CBCCNL/<br><strong>CBC - Conexión Caja Bancaria CORPORATIVA<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257912-WO0000003283920<\/br>/' output.txt
sed -i '' 's/CBCIP/10.139.2.20/' output.txt
sed -i '' 's/CBCPORT/40006,65004/' output.txt
sed -i '' 's/CDBCNL/<br><strong>CDB - Cálculo CVV2-Debito<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257912-WO0000003283920<\/br>/' output.txt
sed -i '' 's/CDBIP/10.139.2.11/' output.txt
sed -i '' 's/CDBPORT/40014/' output.txt
sed -i '' 's/CVPCNL/<br><strong>CVP - Cálculo CVV2-Credito<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257912-WO0000003283920<\/br>/' output.txt
sed -i '' 's/CVPIP/10.139.2.13/' output.txt
sed -i '' 's/CVPPORT/40005/' output.txt
sed -i '' 's/FAPCNL/<br><strong>FAP - Conexión tiendas Falabella POS PERU<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257912-WO0000003283920<\/br>/' output.txt
sed -i '' 's/FAPIP/10.139.8.136             10.139.8.138             F5 10.245.229.10  /' output.txt
sed -i '' 's/FAPPORT/40007/' output.txt
sed -i '' 's/OMNCNL/<br><strong>OMN - FP - Omnichanel Corporativo<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_002<\/br><br><strong>WO:<\/strong>REQ000004257913-WO0000003283921<\/br>/' output.txt
sed -i '' 's/OMNIP/10.139.2.10/' output.txt
sed -i '' 's/OMNPORT/40004/' output.txt
sed -i '' 's/PMTCNL/<br><strong>PMT - FP - Payments Corporativo<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_002<\/br><br><strong>WO:<\/strong>REQ000004257913-WO0000003283921<\/br>/' output.txt
sed -i '' 's/PMTIP/10.139.2.16/' output.txt
sed -i '' 's/PMTPORT/40015/' output.txt
sed -i '' 's/PVFCNL/<br><strong>PVF - Puntos Viajes Falabella<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_002<\/br><br><strong>WO:<\/strong>REQ000004257913-WO0000003283921<\/br>/' output.txt
sed -i '' 's/PVFIP/10.139.2.18/' output.txt
sed -i '' 's/PVFPORT/40010/' output.txt
sed -i '' 's/QPYCNL/<br><strong>QPY - FP - QuickPay Corporativo<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_002<\/br><br><strong>WO:<\/strong>REQ000004257913-WO0000003283921<\/br>/' output.txt
sed -i '' 's/QPYIP/10.139.2.15/' output.txt
sed -i '' 's/QPYPORT/40012/' output.txt
sed -i '' 's/SDMCNL/<br><strong>SDM - Sodimac<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_002<\/br><br><strong>WO:<\/strong>REQ000004257913-WO0000003283921<\/br>/' output.txt
sed -i '' 's/SDMIP/10.139.2.8/' output.txt
sed -i '' 's/SDMPORT/40009/' output.txt
sed -i '' 's/TIBCNL/<br><strong>TIB - Conexión con TIB<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_003<\/br><br><strong>WO:<\/strong>REQ000004257915-WO0000003283922<\/br>/' output.txt
sed -i '' 's/TIBIP/10.245.229.10/' output.txt
sed -i '' 's/TIBPORT/40002/' output.txt
sed -i '' 's/TINCNL/<br><strong>TIN - Canal TIN<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_003<\/br><br><strong>WO:<\/strong>REQ000004257915-WO0000003283922<\/br>/' output.txt
sed -i '' 's/TINIP/10.245.229.10/' output.txt
sed -i '' 's/TINPORT/40001/' output.txt
sed -i '' 's/TOPCNL/<br><strong>TOP - FRONT Totus 4.2<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFPE_VPNSSL_P9_003<\/br><br><strong>WO:<\/strong>REQ000004257915-WO0000003283922<\/br>/' output.txt
sed -i '' 's/TOPIP/LINKUBAF1     172.24.4.182         Apagado -LNKUBAF1      172.24.9.102   1     Activo -IP 2: 172.24.9.107  -Firewall vsys1 Peru  NAT DST 172.25.36.6    1 -Firewall vsys1 Peru  NAT DST 172.25.36.27  2 -Firewall vsys3 Peru -NAT SRC 172.24.6.138  1 -Firewall vsys1 Peru  NAT SRC 172.24.6.140  2 -bancared/' output.txt
sed -i '' 's/TOPPORT/40008/' output.txt