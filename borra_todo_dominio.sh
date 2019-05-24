#!/bin/bash
#


#Borra mensajes cuarentena de todo un dominio


#Control Numero parametros
if test $# -ne	1
then
				echo "ERROR FALTAN PARAMETROS"
				echo "$0 DOMINIO"
				exit
fi

DOMINIO=$1

#Extraemos ruta donde se ejecuta
NAME=$(basename $0)
PRG=$(echo "$0" | sed -e "s/${NAME}//")

CUENTAS=$(${PRG}/ver_cuarentena_dominio.sh ${DOMINIO})


#Procesando cada cuenta
while read -r EMAIL
do
	echo "${EMAIL}"
	${PRG}/borra_msg_email.sh ${EMAIL}

done <<< "${CUENTAS}"
