#!/bin/bash

if [[ ${KUBECONFIG} == "" ]]
then
    echo "Please export KUBECONFIG env variable before running script!!!"
    exit 1
else
    echo "Current value of KUBECONFIG --> [${KUBECONFIG}]"
fi

export $(xargs <.env)

cd "01-3-local-provisioner"
helm dependency update
helm upgrade -i init-local-storage ./helm/provisioner -f values-${ENV}.yaml -n local-storage-provisioner --create-namespace
cd ..
