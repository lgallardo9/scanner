#!/bin/bash

# Definir los prefijos
prefijos=("COFRTATMQA" "COFRTBCMQA" "COFRTBCOQA" "COFRTCBCQA" "COFRTCBNQA" "COFRTCDTQA" "COFRTCNVQA" "COFRTCVPQA" "COFRTFALQA" "COFRTHOMQA" "COFRTMKRQA" "COFRTOMNQA" "COFRTPMTQA" "COFRTPSEQA" "COFRTQPYQA" "COFRTTYAQA")


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

sed -i '' 's/ATMCNL/<br><strong>ATM - Red de Cajeros Propios<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257300-WO0000003283917<\/br>/' output.txt
sed -i '' 's/ATMIP/10.139.2.34 (F5 10.139.0.249 10202)/' output.txt
sed -i '' 's/ATMPORT/20302,20303/' output.txt
sed -i '' 's/BCMCNL/<br><strong>BCM - Conexión Banca Movil<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257300-WO0000003283917<\/br>/' output.txt
sed -i '' 's/BCMIP/10.139.2.36/' output.txt
sed -i '' 's/BCMPORT/20321/' output.txt
sed -i '' 's/BCOCNL/<br><strong>BCO - Aplicativo Backoffice Colombia<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257300-WO0000003283917<\/br>/' output.txt
sed -i '' 's/BCOIP/10.139.2.37/' output.txt
sed -i '' 's/BCOPORT/20326/' output.txt
sed -i '' 's/CBCCNL/<br><strong>CBC - Conexión Caja Bancaria CORPORATIVA<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257300-WO0000003283917<\/br>/' output.txt
sed -i '' 's/CBCIP/10.139.2.38/' output.txt
sed -i '' 's/CBCPORT/20329/' output.txt
sed -i '' 's/CBNCNL/<br><strong>CBN - Conexión Caja Bancaria<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_001<\/br><br><strong>WO:<\/strong>REQ000004257300-WO0000003283917<\/br>/' output.txt
sed -i '' 's/CBNIP/10.139.2.39/' output.txt
sed -i '' 's/CBNPORT/20310/' output.txt

sed -i '' 's/CNVCNL/<br><strong>CNV - Convenios Falabella-Multiples Comercios<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_002<\/br><br><strong>WO:<\/strong>REQ000004257905-WO0000003283918<\/br>/' output.txt
sed -i '' 's/CNVIP/10.139.2.41/' output.txt
sed -i '' 's/CNVPORT/20328/' output.txt
sed -i '' 's/CVPCNL/<br><strong>CVP - Cálculo CVV2<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_002<\/br><br><strong>WO:<\/strong>REQ000004257905-WO0000003283918<\/br>/' output.txt
sed -i '' 's/CVPIP/10.139.2.43/' output.txt
sed -i '' 's/CVPPORT/20325/' output.txt
sed -i '' 's/FALCNL/<br><strong>FAL - Conexión tiendas Falabella POS<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_002<\/br><br><strong>WO:<\/strong>REQ000004257905-WO0000003283918<\/br>/' output.txt
sed -i '' 's/FALIP/10.139.2.44/' output.txt
sed -i '' 's/FALPORT/20315/' output.txt
sed -i '' 's/HOMCNL/<br><strong>HOM - Tiendas Homecenter<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_002<\/br><br><strong>WO:<\/strong>REQ000004257905-WO0000003283918<\/br>/' output.txt
sed -i '' 's/HOMIP/10.139.2.46/' output.txt
sed -i '' 's/HOMPORT/20316/' output.txt
sed -i '' 's/MKRCNL/<br><strong>MKR - Conexión Tiendas Makro<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_002<\/br><br><strong>WO:<\/strong>REQ000004257905-WO0000003283918<\/br>/' output.txt
sed -i '' 's/MKRIP/10.139.2.47 (nat destino 172.35.200.14)/' output.txt
sed -i '' 's/MKRPORT/20322/' output.txt
sed -i '' 's/OMNCNL/<br><strong>OMN - Omnichanel<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_003<\/br><br><strong>WO:<\/strong>REQ000004257908-WO0000003283919<\/br>/' output.txt
sed -i '' 's/OMNIP/10.139.2.48/' output.txt
sed -i '' 's/OMNPORT/20313/' output.txt
sed -i '' 's/PMTCNL/<br><strong>PMT - Canal Payments<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_003<\/br><br><strong>WO:<\/strong>REQ000004257908-WO0000003283919<\/br>/' output.txt
sed -i '' 's/PMTIP/10.139.2.49/' output.txt
sed -i '' 's/PMTPORT/20327/' output.txt
sed -i '' 's/PSECNL/<br><strong>PSE - Botón de pagos seguros.<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_003<\/br><br><strong>WO:<\/strong>REQ000004257908-WO0000003283919<\/br>/' output.txt
sed -i '' 's/PSEIP/10.139.2.50/' output.txt
sed -i '' 's/PSEPORT/20324/' output.txt
sed -i '' 's/QPYCNL/<br><strong>QPY - Quickpay<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_003<\/br><br><strong>WO:<\/strong>REQ000004257908-WO0000003283919<\/br>/' output.txt
sed -i '' 's/QPYIP/10.139.2.51/' output.txt
sed -i '' 's/QPYPORT/20314/' output.txt
sed -i '' 's/TYACNL/<br><strong>TYA - Transferencias inmediatas<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCO_VPNSSL_P9_003<\/br><br><strong>WO:<\/strong>REQ000004257908-WO0000003283919<\/br>/' output.txt
sed -i '' 's/TYAIP/10.139.2.77/' output.txt
sed -i '' 's/TYAPORT/20300/' output.txt