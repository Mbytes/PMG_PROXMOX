#!/bin/bash
#

#Liberamos mensajes cuarentena de un dominio

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

###########
# PRINCIPAL
###########

#Listamos cuentas con SPAM
CUENTAS=$(${PRG}/ver_cuarentena_spam.sh ${DOMINIO})

TREG=0
#Mostramos de cada cuenta
while read -r EMAIL
do
	IDMSG=$(${PRG}/ver_msg_email.sh ${EMAIL} | grep "SCORE=" | awk '{print $1}')

	REG=0			#Contador

	#Enviamos cada mensaje
	while read -r LINE
	do
		#echo "deliver ${LINE}"
		if test ${#LINE} -gt 1		#Tenemos registro
		then
			${PRG}/deliver_msg.sh ${LINE}
			let "REG++"
		fi

	done <<< "${IDMSG}"
	echo "${REG}  => ${EMAIL}"

	#Totaliza
	((TREG+=REG))

done <<< "${CUENTAS}"

echo "========================"
echo "TOTAL enviados = ${TREG}"
