#!/bin/bash
#

#Erase ALL msg for a doamin


#Test paramers
if test $# -ne	1
then
				echo "ERROR fault parameters"
				echo "$0 DOMAIN"
				exit
fi

DOMINIO=$1

#Extraemos ruta donde se ejecuta
NAME=$(basename $0)
PRG=$(echo "$0" | sed -e "s/${NAME}//")

CUENTAS=$(${PRG}/ver_cuarentena.sh ${DOMINIO})


#Procesando cada cuenta
while read -r EMAIL
do
	echo "${EMAIL}"
	${PRG}/del_msg_email.sh ${EMAIL}

done <<< "${CUENTAS}"
