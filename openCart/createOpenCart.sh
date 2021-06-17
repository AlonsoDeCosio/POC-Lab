#!/bin/bash
# Create the open cart machine

i=1
req=2
baseName="poc-lab"

echo "Configuring Azure VM"
echo "----------------"
while [ $i -le $req ]
do
echo "Creating machine ${i} out of ${req}"
az vm create --name ${baseName}-${i} --resource-group alonso-rg --image bitnami:opencart:2-1:latest --admin-username dynatrace --admin-password dynatrace2021! --tags Owner=AlonsoDeCosio Purpose=poc-lab --nsg poc-lab-nsg
vmIP=$(az vm list-ip-addresses --name ${baseName}-${i} --query [0].virtualMachine.network.publicIpAddresses[0].ipAddress | sed 's/"//g')
echo "The IP -> ${vmIP}"
i=$[$i+1]
done
