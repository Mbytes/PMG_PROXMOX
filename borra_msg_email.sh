#!/bin/bash
#


#Borra mensajes de un usuario


#Control Numero parametros
if test $# -ne	1
then
				echo "ERROR FALTAN PARAMETROS"
				echo "$0 EMAIL"
				exit
fi

EMAIL=$1

#Listamos
ID=$(pmgsh get /quarantine/spam -starttime `date +%s -d '10 day ago'` -endtime `date +%s` -pmail ${EMAIL} 2>/dev/null | grep 'id"' | awk '{print $3}' | sed -e 's/"//g' | sed -e 's/,//g' )

#Borramos
while read -r LINE
do
	echo "ID= ${LINE}"
	if test ${#LINE} -gt 0
	then
		pmgsh create /quarantine/content --action delete -id  ${LINE} 2>/dev/null
	fi
done <<< "${ID}"
