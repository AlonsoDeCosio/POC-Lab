log in in Heroku
heroku container:login

puch an image https://devcenter.heroku.com/articles/container-registry-and-runtime#pushing-an-existing-image
docker tag <image> registry.heroku.com/<app>/<process-type>
docker push registry.heroku.com/<app>/<process-type>


heroku container:push



commands to create heroku

heroku create <name of app>
heroku stack:set container -a <name of app>

cd <project>
git init
heroku git:remote -a <name of app>

git add .
git commit -am "<commit message>"
git push heroku master

add dynatrace on heroku
heroku buildpacks:set https://github.com/Dynatrace/heroku-buildpack-dynatrace.git#latest -a <name of app>
heroku buildpacks:add https://github.com/Dynatrace/heroku-buildpack-dynatrace.git

heroku config:set DT_TENANT=bab85675
heroku config:set DT_API_URL=https://bab85675.sprint.dynatracelabs.com
heroku config:set DT_API_TOKEN=dt0c01.3PTUZD55DSHWJMBQKHR7XEZX.LWLRELV26UGOVFGJMZ4Z6RD6RH6PALXGLH7CD4RKWHBUESAXYI2Y4XC3ANFYRTSE

generate a new build 
git add .
git commit -am "Add DT agent buildpacks"
git push heroku master



Get the IP of mongo service
kubectl get svc mongo-ext --output jsonpath='{.status.loadBalancer.ingress[0].ip}'


heroku config:set LCB_DATABASE_URI=mongodb://dynatrace:dynatrace2021@20.81.0.34:27017/

heroku buildpacks:add https://github.com/Dynatrace/heroku-buildpack-dynatrace.git

heroku config:set DT_TENANT=dba19199
heroku config:set DT_API_TOKEN=dt0c01.6XGKBW6WQKSHB4YALMWFORXG.2IP56PNE2VDPQNS6UEXXOJ3IDBPFSV2FEAJLJGQJ2ONECA3CSV77UIM4SM4INHET


<!-- I need to update the setting and the env variable with the mongodb info -->



<!-- Heroku -->

heroku create poc-lab-1
git init
heroku git:remote -a polar-depths-22687
heroku config:set LCB_DATABASE_URI=mongodb://dynatrace:dynatrace2021@20.81.0.34:27017/

git add .
git commit -am "make it better"
git push heroku master

heroku buildpacks:add https://github.com/Dynatrace/heroku-buildpack-dynatrace.git
heroku config:set DT_TENANT=bab85675
heroku config:set DT_API_URL=https://bab85675.sprint.dynatracelabs.com/api
heroku config:set DT_API_TOKEN=dt0c01.VI2RG2RZIKZVLVDSOI6SVL63.R66SLM3QHZGFWGCW6JQSMQCJDPCZB64ZPV4VUDUZIGB2UDPU2LKD2L26FDXPLJVK



mongodb://dynatrace:dynatrace2021@20.81.0.34:27017/
mongodb://dynatrace:dynatrace2021@20.81.0.34:27017/letschat