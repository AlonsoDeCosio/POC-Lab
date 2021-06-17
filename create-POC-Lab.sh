#!/bin/bash

i=1
baseName="poc-lab-k8"

# validate is the user has an azure account
azAccount=$(az account show --output json | jq -r '.state')
if [[ $azAccount != "Enabled" ]]
then
  echo "You need to Login to your Azure account"
  exit 1
fi

# create de main menu
clear
echo "----------------"
echo "POC-LAB automation tools"
echo "----------------"
echo -en '\n'
echo "The base name for the environments will be '${baseName}'"
read -p "How many environments do you need: " req

# Loop to create all the environments for the users (the environments are created and configured one by one) 
clear
while [ $i -le $req ]
do
echo "Creating Environments ${i} out of ${req}"
# smaller machine for AKS
# az aks create --name ${baseName}-${i} --resource-group alonso-rg --location eastus --node-vm-size Standard_B2s --node-count 1
# Bigger machine for AKS
# az aks create --name ${baseName}-${i} --resource-group alonso-rg --location eastus --node-count 1
az aks create --name ${baseName}-${i} --resource-group alonso-rg --location eastus
az aks get-credentials --resource-group alonso-rg --name ${baseName}-${i}
kubectl config use-context ${baseName}-${i}

sleep 30

echo -en '\n'
echo "----------------"
echo "Configure LinkerD"
echo "----------------"
echo -en '\n'

curl -sL https://run.linkerd.io/install | sh
export PATH=$PATH:/Users/alonso.decosio/.linkerd2/bin
linkerd check --pre

linkerd install | kubectl apply -f -
LinkerDState=$(kubectl get deploy linkerd-controller -n linkerd -o jsonpath={.status.readyReplicas})
while [[  $LinkerDState != 1  ]]; do
    echo "LinkerD Not Ready..."
    sleep 10
    LinkerDState=$(kubectl get deploy linkerd-controller -n linkerd -o jsonpath={.status.readyReplicas})
done

echo -en '\n'
echo "----------------"
echo "Configure LinkerD-Viz"
echo "----------------"
echo -en '\n'

linkerd viz install | kubectl apply -f -
LinkerDVizState=$(kubectl get deploy web -n linkerd-viz -o jsonpath={.status.readyReplicas})
while [[  $LinkerDVizState != 1  ]]; do
    echo "LinkerD-Viz Not Ready..."
    sleep 10
    LinkerDVizState=$(kubectl get deploy web -n linkerd-viz -o jsonpath={.status.readyReplicas})
done

# Deploy EmojiVoto
echo -en '\n'
echo "----------------"
echo "Configuring EmojiVoto application"
echo "----------------"
echo -en '\n'

curl -sL https://run.linkerd.io/emojivoto.yml | kubectl apply -f -
sleep 20
kubectl apply -f ./emojivoto/emojivoto.yaml

# Configuring Kafka
echo -en '\n'
echo "----------------"
echo "Configuring Kafka"
echo "----------------"
echo -en '\n'

helm repo add bitnami https://charts.bitnami.com/bitnami > /dev/null 2>&1
helm install poc-lab-kafka bitnami/kafka > /dev/null 2>&1

kafkaState=$(kubectl get po poc-lab-kafka-0 --output jsonpath={.status.containerStatuses[0].started})
while [[  $kafkaState != true  ]]; do
    echo "Kafka Not Ready..."
    sleep 10
    kafkaState=$(kubectl get po poc-lab-kafka-0 --output jsonpath={.status.containerStatuses[0].started})
done

# Configuring Tracing App
echo -en '\n'
echo "----------------"
echo "Deploying the Tracing App"
echo "----------------"
echo -en '\n'

kubectl apply -f ./tracing/tracing-app.yaml

# Configuring Voting App
echo -en '\n'
echo "----------------"
echo "Deploying the Voting App"
echo "----------------"
echo -en '\n'

kubectl apply -f ./Voting/voting-app.yaml

# inject LinkerD to the applications
echo -en '\n'
echo "----------------"
echo "Configuring Emojivoto with LinkerD"
echo "----------------"
echo -en '\n'

kubectl get -n emojivoto deploy -o yaml | linkerd inject - | kubectl apply -f -

echo -en '\n'
echo "----------------"
echo "Configuring Tracing App with LinkerD"
echo "----------------"
echo -en '\n'

kubectl get deploy -o yaml | linkerd inject - | kubectl apply -f -

echo -en '\n'
echo "----------------"
echo "The Kubernetes cluster has been successfully configured"
echo "----------------"
echo -en '\n'

echo -en '\n'
echo "----------------"
echo "Configure Heroku"
echo "----------------"
echo -en '\n'

kubectl apply -f ./letsChat/mongoLetsChat.yaml
sleep 20
getMongoIP=$(kubectl get svc mongo-letschat-ext --output jsonpath='{.status.loadBalancer.ingress[0].ip}')

while [ $? -ne 0 ] || [  -z "${getMongoIP}" ]; do
    echo "Heroku MongoDB service not available..."
    sleep 2
    getMongoIP=$(kubectl get svc mongo-letschat-ext --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
done

# update the Heroku Dockerfile with the mongo service ip
echo -en '\n'
echo "----------------"
echo "Updating App Settings"
echo "----------------"
echo -en '\n'

rm -f ./letsChat/settings.yml
cp ./letsChat/settings.yml.sample ./letsChat/settings.yml
sed -i '' "s/localhost/dynatrace:dynatrace2021@${getMongoIP}:27017/" ./letsChat/settings.yml

#create the Heroku part
herokuAppName=${baseName}-${i}
appList=$(heroku list)

if [[ $appList =~ $herokuAppName ]]; then
  echo -en '\n'
  echo "----------------"
  echo "Deleting the old Heroku App"
  echo "----------------"
  echo -en '\n'

  heroku apps:destroy --app=${baseName}-${i} --confirm=${baseName}-${i}
fi
echo -en '\n'
echo "----------------"
echo "Creating the Heroku App"
echo "----------------"
echo -en '\n'

cd ./letsChat
rm -Rf .git
heroku create ${baseName}-${i}
git init
heroku git:remote -a ${baseName}-${i}
heroku config:set LCB_DATABASE_URI=mongodb://dynatrace:dynatrace2021@${getMongoIP}:27017/
heroku buildpacks:add heroku/nodejs
# heroku buildpacks:add https://github.com/Dynatrace/heroku-buildpack-dynatrace.git -a ${baseName}-${i}
# heroku config:set DT_TENANT=<Tenant_ID> -a ${baseName}-${i}
# heroku config:set DT_API_URL=<Tenant_URL> -a ${baseName}-${i}
# heroku config:set DT_API_TOKEN=<Token_ID> -a ${baseName}-${i}

git add . > /dev/null 2>&1
git commit -am "First Commit" --allow-empty > /dev/null 2>&1
git push heroku master
cd ..

# Cerate Azure VM and configure OpenCart
echo -en '\n'
echo "----------------"
echo "Creating OpenCart Machine"
echo "----------------"
echo -en '\n'

az vm create --name ${baseName}-${i} --resource-group alonso-rg --image bitnami:opencart:2-1:latest --admin-username dynatrace --admin-password dynatrace2021! --tags Owner=AlonsoDeCosio Purpose=poc-lab --nsg poc-lab-nsg
vmIP=$(az vm list-ip-addresses --name ${baseName}-${i} --query [0].virtualMachine.network.publicIpAddresses[0].ipAddress | sed 's/"//g')
echo "The IP -> ${vmIP}"

i=$[$i+1]
done
