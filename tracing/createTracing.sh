#!/bin/bash
# bash script to create de lets-chat applications for the poc-lab

# Configuring Kafka
echo "----------------"
echo "Configuring Kafka"
helm repo add bitnami https://charts.bitnami.com/bitnami > /dev/null 2>&1
helm install poc-lab-kafka bitnami/kafka > /dev/null 2>&1

kafkaState=$(kubectl get po poc-lab-kafka-0 --output jsonpath={.status.containerStatuses[0].ready})
while [ $? -ne 0 ] || [  $kafkaState != true  ]; do
    echo "Kafka Not Ready..."
    sleep 5
    kafkaState=$(kubectl get po poc-lab-kafka-0 --output jsonpath={.status.containerStatuses[0].ready})
done

# Configuring the application
echo "----------------"
echo "Deploying the Apps"
kubectl create -f tracing-app.yaml

# echo "----------------"
# echo "Getting data from Kubernetes"
# getMongoIP=$(kubectl get svc mongo-ext --output jsonpath='{.status.loadBalancer.ingress[0].ip}')

# while [ $? -ne 0 ] | [  -z "${getMongoIP}" ]; do
#     sleep 2
#     getMongoIP=$(kubectl get svc mongo-ext --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
# done

# echo "-> The external ip is -> ${getMongoIP}"


echo "----------------"
echo "Application successfully deployed"
echo "----------------"