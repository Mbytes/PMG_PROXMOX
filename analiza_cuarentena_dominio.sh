#!/bin/bash
#

#Analiza mensajes en cuarentena ordenando


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

#Extraemos asuntos de mensaje...

${PRG}/ver_cuarentena_dominio.sh ${DOMINIO} | grep SPAM  | sort | uniq -c | sort -nr
