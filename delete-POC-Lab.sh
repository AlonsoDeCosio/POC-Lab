#!/bin/bash

i=1
baseName="poc-lab-k8"

# create de main menu
echo "----------------"
echo "POC-LAB deletion automation tools"
echo "----------------"
read -p "How many environments do you need to delete: " req

clear
while [ $i -le $req ]
do
echo "Deleting Environments ${i} out of ${req}"

kubectl config delete-context ${baseName}-${i}
kubectl config delete-cluster ${baseName}-${i}
kubectl config use-context docker-desktop
heroku apps:destroy --app=${baseName}-${i} --confirm=${baseName}-${i}
az aks delete --name ${baseName}-${i} --resource-group alonso-rg --yes
az vm delete --name ${baseName}-${i} --resource-group alonso-rg --yes

i=$[$i+1]
done
