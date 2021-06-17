How to start the program 

Start Kafka

helm repo add bitnami https://charts.bitnami.com/bitnami
helm install poc-lab-kafka bitnami/kafka

Uninstalling the Chart
helm delete poc-lab-kafka

agregar esto para que use la imagen local

--image-pull-policy=Never
imagePullPolicy: Never


Information from Kafka

NAME: poc-lab-kafka
LAST DEPLOYED: Tue Mar 23 14:10:17 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

Kafka can be accessed by consumers via port 9092 on the following DNS name from within your cluster:

    poc-lab-kafka.default.svc.cluster.local
    

Each Kafka broker can be accessed by producers via port 9092 on the following DNS name(s) from within your cluster:

    poc-lab-kafka-0.poc-lab-kafka-headless.default.svc.cluster.local:9092

To create a pod that you can use as a Kafka client run the following commands:

    kubectl run poc-lab-kafka-client --image docker.io/bitnami/kafka:2.7.0-debian-10-r90 --command -- sleep infinity
    kubectl exec --tty -i poc-lab-kafka-client -- bash

    PRODUCER:
        kafka-console-producer.sh --broker-list poc-lab-kafka-0.poc-lab-kafka-headless.default.svc.cluster.local:9092 --topic test

    CONSUMER:
        kafka-console-consumer.sh --bootstrap-server poc-lab-kafka.default.svc.cluster.local:9092 --topic LabTopic_RawResult --from-beginning
        kafka-console-consumer.sh --bootstrap-server poc-lab-kafka.default.svc.cluster.local:9092 --topic LabTopic_ProcessResult --from-beginning




kubectl run fp --image=alonsodecosio/poc-lab-fp --image-pull-policy=Never
kubectl run -it cp --image=alonsodecosio/poc-lab-cp --image-pull-policy=Never
kubectl run -it cm --image=alonsodecosio/poc-lab-cm --image-pull-policy=Never

192.168.1.124