#!/bin/bash

# Definir los prefijos
prefijos=("CLFRTATMQA" "CLFRTBCHQA" "CLFRTBCOQA" "CLFRTBDPQA" "CLFRTBESQA" "CLFRTCDBQA" "CLFRTCLRQA" "CLFRTCVPQA" "CLFRTENTQA" "CLFRTIMPQA" "CLFRTMOVQA" "CLFRTNOTQA" "CLFRTNTWQA" "CLFRTOMNQA" "CLFRTPMTQA" "CLFRTPOSQA" "CLFRTQPYQA" "CLFRTRCDQA" "CLFRTSODQA" "CLFRTSVPQA" "CLFRTTBCQA" "CLFRTTBKQA" "CLFRTTOTQA" "CLFRTWEBQA")


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

sed -i '' 's/ATMCNL/<br><strong>ATM - Red de Cajeros Propios<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_001-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257627-WO0000003283911<\/br>/' output.txt
sed -i '' 's/ATMIP/QA P9	FRONT-01   Active 	VIP	10.139.2.52-	FRONT-02  Inactive 	VIP	10.139.2.52-/' output.txt
sed -i '' 's/ATMPORT/16100 al 16120 (atm fisico),17500 al 17530  (atm fsimulador),17900 al 17910  (atm simulador)/' output.txt
sed -i '' 's/BCHCNL/<br><strong>BCH - BFCL - Banco Estado<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_001-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257627-WO0000003283911<\/br>/' output.txt
sed -i '' 's/BCHIP/10.139.2.53  NAT 163.250.211.104 /' output.txt
sed -i '' 's/BCHPORT/20010, 20011/' output.txt
sed -i '' 's/BCOCNL/<br><strong>BCO - BFCL-Aplicativo Backoffice<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_001-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257627-WO0000003283911<\/br>/' output.txt
sed -i '' 's/BCOIP/10.139.2.54/' output.txt
sed -i '' 's/BCOPORT/30216/' output.txt
sed -i '' 's/BDPCNL/<br><strong>BDP - Botón de Pago<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_002-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257849-WO0000003283912<\/br>/' output.txt
sed -i '' 's/BDPIP/10.139.2.55/' output.txt
sed -i '' 's/BDPPORT/30217/' output.txt
sed -i '' 's/BESCNL/<br><strong>BES - BFCL - Banco Estado Emisor<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_002-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004363027<\/br>/' output.txt
sed -i '' 's/BESIP/10.139.2.56  NAT 163.250.211.106 /' output.txt
sed -i '' 's/BESPORT/20020, 20021/' output.txt
sed -i '' 's/CDBCNL/<br><strong>CDB - Cálculo CVV2 Debito<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_002-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257849-WO0000003283912<\/br>/' output.txt
sed -i '' 's/CDBIP/10.139.2.57/' output.txt
sed -i '' 's/CDBPORT/30219/' output.txt
sed -i '' 's/CLRCNL/<br><strong>CLR - BFCL - Claro Telcos<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_002-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257849-WO0000003283912<\/br>/' output.txt
sed -i '' 's/CLRIP/10.139.2.58/' output.txt
sed -i '' 's/CLRPORT/30220/' output.txt
sed -i '' 's/CVPCNL/<br><strong>CVP - Cálculo CVV2<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_002-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257849-WO0000003283912<\/br>/' output.txt
sed -i '' 's/CVPIP/10.139.2.59/' output.txt
sed -i '' 's/CVPPORT/30221/' output.txt
sed -i '' 's/ENTCNL/<br><strong>ENT - BFCL - Entel Telcos IVR<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_003-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257854-WO0000003283913<\/br>/' output.txt
sed -i '' 's/ENTIP/10.139.2.60/' output.txt
sed -i '' 's/ENTPORT/30222/' output.txt
sed -i '' 's/IMPCNL/<br><strong>IMP - BFCL - Imperial PCI<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_003-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257854-WO0000003283913<\/br>/' output.txt
sed -i '' 's/IMPIP/10.139.2.61/' output.txt
sed -i '' 's/IMPPORT/30223/' output.txt
sed -i '' 's/MOVCNL/<br><strong>MOV - BFCL - Movistar Telcos IVR<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_003-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257854-WO0000003283913<\/br>/' output.txt
sed -i '' 's/MOVIP/10.139.2.62/' output.txt
sed -i '' 's/MOVPORT/30224/' output.txt
sed -i '' 's/NOTCNL/<br><strong>NOT - Notificaciones SATIF<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_003-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257854-WO0000003283913<\/br>/' output.txt
sed -i '' 's/NOTIP/10.139.2.39/' output.txt
sed -i '' 's/NOTPORT/30225/' output.txt
sed -i '' 's/NTWCNL/<br><strong>NTW-Novedades Corporativo Chile<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_003-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257854-WO0000003283913<\/br>/' output.txt
sed -i '' 's/NTWIP/VIP F5 10.245.229.10-IP Az7 10.139.8.136/' output.txt
sed -i '' 's/NTWPORT/40013 httpadmin,40003 Az7/' output.txt
sed -i '' 's/OMNCNL/<br><strong>OMN - Omnichanel<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_004-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257628-WO0000003283914<\/br>/' output.txt
sed -i '' 's/OMNIP/10.139.2.64/' output.txt
sed -i '' 's/OMNPORT/30226/' output.txt
sed -i '' 's/PMTCNL/<br><strong>PMT - Payments<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_004-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257628-WO0000003283914<\/br>/' output.txt
sed -i '' 's/PMTIP/10.139.2.65/' output.txt
sed -i '' 's/PMTPORT/30227/' output.txt
sed -i '' 's/POSCNL/<br><strong>POS - BFCL - POS Falabella<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_004-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257628-WO0000003283914<\/br>/' output.txt
sed -i '' 's/POSIP/10.139.2.66/' output.txt
sed -i '' 's/POSPORT/30228/' output.txt
sed -i '' 's/QPYCNL/<br><strong>QPY - Quickpay<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_004-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257628-WO0000003283914<\/br>/' output.txt
sed -i '' 's/QPYIP/10.139.2.67/' output.txt
sed -i '' 's/QPYPORT/30229/' output.txt
sed -i '' 's/RCDCNL/<br><strong>RCD - RECAUDACIONES PAGO EECC BFCL<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_004-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257628-WO0000003283914<\/br>/' output.txt
sed -i '' 's/RCDIP/10.139.2.68/' output.txt
sed -i '' 's/RCDPORT/30230/' output.txt
sed -i '' 's/SODCNL/<br><strong>SOD - BFCL - Sodimac<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_005-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257860-WO0000003283915<\/br>/' output.txt
sed -i '' 's/SODIP/10.139.2.69/' output.txt
sed -i '' 's/SODPORT/30231/' output.txt
sed -i '' 's/SVPCNL/<br><strong>SVP - Servipag<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_005-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257860-WO0000003283915<\/br>/' output.txt
sed -i '' 's/SVPIP/10.139.2.70  nat 200.10.167.70 /' output.txt
sed -i '' 's/SVPPORT/30232/' output.txt
sed -i '' 's/TBCCNL/<br><strong>TBC - BFCL - Transbank Crédito<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_005-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257860-WO0000003283915<\/br>/' output.txt
sed -i '' 's/TBCIP/10.139.2.71/' output.txt
sed -i '' 's/TBCPORT/30233/' output.txt
sed -i '' 's/TBKCNL/<br><strong>TBK - BFCL - Transbank<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_005-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257860-WO0000003283915<\/br>/' output.txt
sed -i '' 's/TBKIP/10.139.2.72/' output.txt
sed -i '' 's/TBKPORT/30234/' output.txt
sed -i '' 's/TOTCNL/<br><strong>TOT - BFCL - Tottus<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_006-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257861-WO0000003283916<\/br>/' output.txt
sed -i '' 's/TOTIP/10.139.2.74/' output.txt
sed -i '' 's/TOTPORT/30236/' output.txt
sed -i '' 's/WEBCNL/<br><strong>WEB - WEB<\/strong><\/br><br><strong>Formulario VPN:<\/strong>BFCL_VPNSSL_P9_006-Formulario de Conexiones_Template<\/br><br><strong>WO:<\/strong>REQ000004257861-WO0000003283916<\/br>/' output.txt
sed -i '' 's/WEBIP/10.139.2.75/' output.txt
sed -i '' 's/WEBPORT/30237/' output.txt