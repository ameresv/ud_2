#!/usr/bin/bash

fecha=`date +"%Y-%m-%d"`
file_name="${fecha}_data.xlsx"
output="result.csv"

wget --user-agent="Mozilla" \
  -O ./${file_name} \
  "https://www.osinergmin.gob.pe/seccion/centro_documental/hidrocarburos/SCOP/SCOP-DOCS/2024/Registro-precios/Ultimos-Precios-Registrados-EVPC.xlsx"

echo "${file_name} done"

# xlsx2csv ${file_name} > data.csv

# awk -F "," '{if(($2 == 20122386229) && ($10 == "GASOHOL REGULAR")) { print $3 "," $10 "," $11}}' data.csv

convert_data() {
  xlsx2csv ${file_name} |
   awk -v fecha_awk="$fecha" -F "," '{if(($2 == 20122386229) || ($2 == 20502105613) || ($1 == "18401-107-221119")) { print fecha_awk "," $3 "," $8 "," $10 "," $11 ;}}' |
    awk '/GASOHOL/' >> $output
}

if [ -f "$output" ]; then
  convert_data
else
  echo "DATE,GAS_STATION,UPDATED_AT,PRODUCT,PRICE" > $output 
  convert_data
fi

# Datos para envio a Telegram
token="6222012920:AAG6075letS8iTzfLVAX8p9pkdIEg6FZAmQ"
# token=`printenv API_KEY_AMVARGASBOT`
chat_id="-1001957546724"
# Envio Telegram
curl -s -F chat_id=$chat_id \
    -F document=@${output} \
    -F caption="Combustible hoy @ ${fecha}"\
      https://api.telegram.org/bot${token}/sendDocument
