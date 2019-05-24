#!/bin/bash
#

#Control Numero parametros
if test $# -ne	1
then
				echo "ERROR FALTAN PARAMETROS"
				echo "$0 IDMSG"
				exit
fi



pmgsh create /quarantine/content --action deliver --id $1 &>/dev/null
