#!/bin/bash
#

#Lista mensajes cuarentena VIRUS


#Control Numero parametros
if test $# -ne	1
then
				echo "ERROR FALTAN PARAMETROS"
				echo "$0 [DOMINIO]"
				exit
fi

DOMINIO=$1

#Lista cuentas
pmgsh get /quarantine/virus 2>/dev/null | grep "@$1" | awk '{print $NF}' | sed -e 's/"//g' | sed -e 's/,//g' |sort
