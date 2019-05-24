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

DIAS=10			#Numero dias ha controlar spam
LAST=$(date +%s --date="10 day ago")
NOW=$(date +%s )


#Lista cuentas
pmgsh get /quarantine/spamusers --starttime ${LAST} --endtime ${NOW} 2>/dev/null | grep "@$1" | awk '{print $NF}' | sed -e 's/"//g'
