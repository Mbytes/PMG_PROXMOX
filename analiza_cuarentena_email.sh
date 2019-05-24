#!/bin/bash
#

#Analiza mensajes en cuarentena  de un email y extrae IPs
LOGIP=/tmp/logip_spam.txt
LOGID=/tmp/logid_spam.txt

echo "" >${LOGIP}
echo "" >${LOGID}

#Control Numero parametros
if test $# -ne	1
then
				echo "ERROR FALTAN PARAMETROS"
				echo "$0 [EMAIL]"
				exit
fi

DOMINIO=$1

#Extraemos ruta donde se ejecuta
NAME=$(basename $0)
PRG=$(echo "$0" | sed -e "s/${NAME}//")

#listado de mensajes
LISTAID=$(${PRG}/ver_msg_email.sh $1 |grep -v "SPAM:\|-------------")


#IDs para saca IPs de datos en raw de las cabeceras para luego borrar
while read -r LINE
do

	#echo "${LINE}"
	#ID  y visualizar RAW
	ID=$(echo "${LINE}" | awk '{print $1}')

	echo "ID + ${ID}"
	echo "${ID}" >> ${LOGID}
	#Ver RAW
	RAW=$(pmgsh get /quarantine/content -id ${ID})
	HEADER=$(echo "${RAW}" |jq -jr '.header')

	#sacamos IP para luego procesar
	echo "${HEADER}" | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' >> ${LOGIP}

	#Borramos ID
	pmgsh create /quarantine/content --action delete -id ${ID}


done <<< "${LISTAID}"
