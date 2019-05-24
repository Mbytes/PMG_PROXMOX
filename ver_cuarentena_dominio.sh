#!/bin/bash
#

#Lista mensajes cuarentena


#Control Numero parametros
if test $# -ne	1
then
				echo "ERROR FALTAN PARAMETROS"
				echo "$0 [DOMINIO]"
				exit
fi

DOMINIO=$1

#Extraemos ruta donde se ejecuta
NAME=$(basename $0)
PRG=$(echo "$0" | sed -e "s/${NAME}//")


#Listamos cuentas con SPAM
CUENTAS=$(${PRG}/ver_cuarentena_spam.sh ${DOMINIO})


#Mostramos de cada cuenta
while read -r EMAIL
do
	echo "${EMAIL}"
	${PRG}/ver_msg_email.sh ${EMAIL}

echo "============================"
echo
done <<< "${CUENTAS}"
