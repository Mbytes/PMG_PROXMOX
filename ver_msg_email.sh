#!/bin/bash
#

#Visualia msg un usuario

#Control Numero parametros
if test $# -ne	1
then
				echo "ERROR FALTAN PARAMETROS"
				echo "$0 EMAIL"
				exit
fi

EMAIL=$1

DIAS=10			#Numero dias ha controlar spam
LAST=$(date +%s --date="10 day ago")
NOW=$(date +%s )


#Listamos
ID=$(pmgsh get /quarantine/spam --starttime ${LAST} --endtime ${NOW} -pmail ${EMAIL} 2>/dev/null)

#OK
echo "${ID}" | jq -jr '.[] | .id ,"  SCORE=", .spamlevel, "  ", .from, "\n  ", .subject , "\n--------------------------\n"'


#echo "${ID}" | jq -jr '.[] | {spamlevel, bytes}'
