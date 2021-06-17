#!/bin/bash
# bash script to create de lets-chat applications for the poc-lab

echo "----------------"
echo "Deleting mongo deployment"
kubectl create -f mongoLetsChat.yaml

if [[ $appList =~ $herokuAppName ]]; then
  echo "----------------"
  echo "Deleting the odl Heroku App"
  heroku apps:destroy --app=${herokuAppName} --confirm=${herokuAppName}
fi