#!/usr/bin/env bash

function showhelp(){
    echo -e "\n  Create Certificate Access K8S\n"
    echo -e "  ./action -u [user] -g [group]\n"
    echo -e "  Mandatory arguments\n"
    echo -e "    -u\tUser K8S"
    echo -e "    -g\tGroup K8S\n" 
    exit 0
}

function cert (){
    echo -e "\n[Generate Certificate]"
    echo -e "User: $1\nGroup: $2"
    mkdir -p ./ops
    openssl genrsa -out ./ops/$1.key 2048 &>/dev/null
    openssl req -new -key ./ops/$1.key -out ./ops/$1.csr -subj "/CN=$1/O=$2" &>/dev/null
    echo -e "\n[Signing Certificate CA]"
    sudo openssl x509 -req -in ./ops/$1.csr -CA /home/lucho/.minikube/ca.crt -CAkey /home/lucho/.minikube/ca.key -CAcreateserial -out ./ops/$1.crt -days 500
    if [ $(openssl x509 -in ./ops/$1.crt -noout -text &>/dev/null; echo $?) == 0 ]; then
        echo -e "\n[Succesfuld]"
    else
	echo -e "\n[Failed]"
    fi
}

# Main
## Init
if [[ "$#" == 4 && "$1" == "-u" && "$3" == "-g" ]]; then
    if [[ "$2" != " " && "$4" != " " ]]; then
	cert $2 $4
    else
        echo -e "Todos los parametros son requeridos"
        showhelp
    fi
else
    showhelp
fi
