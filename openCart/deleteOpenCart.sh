#!/bin/bash
# Deleting the open cart machines

i=1
req=1
baseName="poc-lab"

echo "Deleting Azure VM"
echo "----------------"
while [ $i -le $req ]
do
echo "Deleting machine ${i} out of ${req}"
az vm delete -g alonso-rg -n ${baseName}-${i} --yes
i=$[$i+1]
done
