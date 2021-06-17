#!/bin/bash
# bash script to create de lets-chat applications for the poc-lab

# echo "----------------"
# echo "Creating mongo Deployment and Service in Kubernetes"
# createMongo=$(kubectl create -f mongo.yaml)
# sleep 30

echo "----------------"
echo "Getting data from Kubernetes"
getMongoIP=$(kubectl get svc mongo-ext-letschat --output jsonpath='{.status.loadBalancer.ingress[0].ip}')

while [ $? -ne 0 ] | [  -z "${getMongoIP}" ]; do
    echo "error"
    sleep 2
    getMongoIP=$(kubectl get svc mongo-ext-letschat --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
done

echo "-> The external ip is"
echo "${getMongoIP}"

# update the Heroku Dockerfile with the mongo service ip
echo "----------------"
echo "Updating DockerFile"
rm Dockerfile
cp Dockerfile.templet Dockerfile
sed -i '' "s/<ip>/${getMongoIP}/" Dockerfile

#create the Heroku part
echo "----------------"
echo "Creating the Heroku App"
herokuAppName="dt-poc-lab-1"
appList=$(heroku list)

if [[ $appList =~ $herokuAppName ]]; then
  echo "----------------"
  echo "Deleting the applciations from Heroku"
  heroku apps:destroy --app=${herokuAppName} --confirm=${herokuAppName}
fi

heroku create ${herokuAppName}
git init
heroku git:remote -a ${herokuAppName}

heroku buildpacks:set https://github.com/Dynatrace/heroku-buildpack-dynatrace.git#latest -a ${herokuAppName}
heroku config:set DT_TENANT=bab85675 -a ${herokuAppName}
heroku config:set DT_API_URL=https://bab85675.sprint.dynatracelabs.com/ -a ${herokuAppName}
heroku config:set DT_API_TOKEN=dt0c01.ZOEEP4TAB66ZLGS6JQUQLF3C.TEB4ERBS3P3HIKRE3OIAAHI4QXCUUEYJA2SPNXZQL2VLTFS7K3T4DNWWWAKIQYCM -a ${herokuAppName}


git add .
git commit -am "First Commit" --allow-empty
git push heroku master



