#!/bin/bash
# bash script to create de lets-chat applications for the poc-lab

echo "----------------"
echo "Creating mongo Deployment and Service in Kubernetes"
kubectl create -f mongoLetsChat.yaml
sleep 20

echo "----------------"
echo "Getting data from Kubernetes"
getMongoIP=$(kubectl get svc mongo-letschat-ext --output jsonpath='{.status.loadBalancer.ingress[0].ip}')

while [ $? -ne 0 ] || [  -z "${getMongoIP}" ]; do
    echo "error"
    sleep 2
    getMongoIP=$(kubectl get svc mongo-letschat-ext --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
done

echo "-> The external ip is"
echo "${getMongoIP}"

# update the Heroku Dockerfile with the mongo service ip
echo "----------------"
echo "Updating App Settings"
rm -f settings.yml
cp settings.yml.sample settings.yml
sed -i '' "s/localhost/dynatrace:dynatrace2021@${getMongoIP}:27017/" settings.yml

#create the Heroku part
herokuAppName="dt-poc-lab-1"
appList=$(heroku list)

if [[ $appList =~ $herokuAppName ]]; then
  echo "----------------"
  echo "Deleting the odl Heroku App"
  heroku apps:destroy --app=${herokuAppName} --confirm=${herokuAppName}
fi
echo "----------------"
echo "Creating the Heroku App"
rm -Rf .git
heroku create ${herokuAppName}
git init
heroku git:remote -a ${herokuAppName}
heroku config:set LCB_DATABASE_URI=mongodb://dynatrace:dynatrace2021@${getMongoIP}:27017/
heroku buildpacks:add heroku/nodejs

git add . > /dev/null 2>&1
git commit -am "First Commit" --allow-empty > /dev/null 2>&1
git push heroku master



