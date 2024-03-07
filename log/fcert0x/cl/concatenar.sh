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

sed -i '' 's/ATMCNL/ATM - Red de Cajeros Propios/' output.txt
sed -i '' 's/ATMIP/QA P9 FRONT-01  (Active) VIP 10.139.2.52/' output.txt
sed -i '' 's/ATMPORT/16100-16120 (atm fisico),17500-17530  (atm simulador),17900-17910  (atm simulador)/' output.txt
sed -i '' 's/BCHCNL/BCH - BFCL - Banco Estado/' output.txt
sed -i '' 's/BCHIP/10.139.2.53 (NAT 163.250.211.104)/' output.txt
sed -i '' 's/BCHPORT/20010, 20011/' output.txt
sed -i '' 's/BCOCNL/BCO - BFCL-Aplicativo Backoffice/' output.txt
sed -i '' 's/BCOIP/10.139.2.54/' output.txt
sed -i '' 's/BCOPORT/30216/' output.txt
sed -i '' 's/BDPCNL/BDP - Botón de Pago/' output.txt
sed -i '' 's/BDPIP/10.139.2.55/' output.txt
sed -i '' 's/BDPPORT/30217/' output.txt
sed -i '' 's/BESCNL/BES - BFCL - Banco Estado Emisor/' output.txt
sed -i '' 's/BESIP/10.139.2.56 (NAT 163.250.211.106)/' output.txt
sed -i '' 's/BESPORT/20020, 20021/' output.txt
sed -i '' 's/CDBCNL/CDB - Cálculo CVV2 Debito/' output.txt
sed -i '' 's/CDBIP/10.139.2.57/' output.txt
sed -i '' 's/CDBPORT/30219/' output.txt
sed -i '' 's/CLRCNL/CLR - BFCL - Claro(Telcos)/' output.txt
sed -i '' 's/CLRIP/10.139.2.58/' output.txt
sed -i '' 's/CLRPORT/30220/' output.txt
sed -i '' 's/CVPCNL/CVP - Cálculo CVV2/' output.txt
sed -i '' 's/CVPIP/10.139.2.59/' output.txt
sed -i '' 's/CVPPORT/30221/' output.txt
sed -i '' 's/ENTCNL/ENT - BFCL - Entel Telcos IVR/' output.txt
sed -i '' 's/ENTIP/10.139.2.60/' output.txt
sed -i '' 's/ENTPORT/30222/' output.txt
sed -i '' 's/IMPCNL/IMP - BFCL - Imperial PCI/' output.txt
sed -i '' 's/IMPIP/10.139.2.61/' output.txt
sed -i '' 's/IMPPORT/30223/' output.txt
sed -i '' 's/MOVCNL/MOV - BFCL - Movistar Telcos IVR/' output.txt
sed -i '' 's/MOVIP/10.139.2.62/' output.txt
sed -i '' 's/MOVPORT/30224/' output.txt
sed -i '' 's/NOTCNL/NOT - Notificaciones SATIF/' output.txt
sed -i '' 's/NOTIP/10.139.2.39/' output.txt
sed -i '' 's/NOTPORT/30225/' output.txt
sed -i '' 's/NTWCNL/NTW-Novedades Corporativo Chile/' output.txt
sed -i '' 's/NTWIP/VIP F5 10.245.229.10 IP Az7 10.139.8.136/' output.txt
sed -i '' 's/NTWPORT/40013 httpadmin 40003 Az7/' output.txt
sed -i '' 's/OMNCNL/OMN - Omnichanel/' output.txt
sed -i '' 's/OMNIP/10.139.2.64/' output.txt
sed -i '' 's/OMNPORT/30226/' output.txt
sed -i '' 's/PMTCNL/PMT - Payments/' output.txt
sed -i '' 's/PMTIP/10.139.2.65/' output.txt
sed -i '' 's/PMTPORT/30227/' output.txt
sed -i '' 's/POSCNL/POS - BFCL - POS Falabella/' output.txt
sed -i '' 's/POSIP/10.139.2.66/' output.txt
sed -i '' 's/POSPORT/30228/' output.txt
sed -i '' 's/QPYCNL/QPY - Quickpay/' output.txt
sed -i '' 's/QPYIP/10.139.2.67/' output.txt
sed -i '' 's/QPYPORT/30229/' output.txt
sed -i '' 's/RCDCNL/RCD - RECAUDACIONES PAGO EECC BFCL/' output.txt
sed -i '' 's/RCDIP/10.139.2.68/' output.txt
sed -i '' 's/RCDPORT/30230/' output.txt
sed -i '' 's/SODCNL/SOD - BFCL - Sodimac/' output.txt
sed -i '' 's/SODIP/10.139.2.69/' output.txt
sed -i '' 's/SODPORT/30231/' output.txt
sed -i '' 's/SVPCNL/SVP - Servipag/' output.txt
sed -i '' 's/SVPIP/10.139.2.70 (nat 200.10.167.70)/' output.txt
sed -i '' 's/SVPPORT/30232/' output.txt
sed -i '' 's/TBCCNL/TBC - BFCL - Transbank Crédito/' output.txt
sed -i '' 's/TBCIP/10.139.2.71/' output.txt
sed -i '' 's/TBCPORT/30233/' output.txt
sed -i '' 's/TBKCNL/TBK - BFCL - Transbank/' output.txt
sed -i '' 's/TBKIP/10.139.2.72/' output.txt
sed -i '' 's/TBKPORT/30234/' output.txt
sed -i '' 's/TOTCNL/TOT - BFCL - Tottus/' output.txt
sed -i '' 's/TOTIP/10.139.2.74/' output.txt
sed -i '' 's/TOTPORT/30236/' output.txt
sed -i '' 's/WEBCNL/WEB - WEB/' output.txt
sed -i '' 's/WEBIP/10.139.2.75/' output.txt
sed -i '' 's/WEBPORT/30237/' output.txt