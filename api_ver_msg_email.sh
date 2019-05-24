#!/bin/bash
#


#Lista mensajes de un usario en formato 1 linea


#Control Numero parametros
if test $# -ne	1
then
				echo "ERROR FALTAN PARAMETROS"
				echo "$0 EMAIL"
				exit
fi

EMAIL=$1

#Listamos
ID=$(pmgsh get /quarantine/spam -pmail ${EMAIL} 2>/dev/null)

#OK
echo "${ID}" | jq -jr '.[] | .id ,"  SCORE=", .spamlevel, "  \"", .from, "\"  \"", .subject , "\"\n"'


#echo "${ID}" | jq -jr '.[] | {spamlevel, bytes}'
