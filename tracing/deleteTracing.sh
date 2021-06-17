#!/bin/bash
# bash script to create de lets-chat applications for the poc-lab

echo "----------------"
echo "Deleting Apps"
kubectl delete -f tracing-app.yaml

echo "----------------"
echo "deleting Kafka"
helm delete poc-lab-kafka
