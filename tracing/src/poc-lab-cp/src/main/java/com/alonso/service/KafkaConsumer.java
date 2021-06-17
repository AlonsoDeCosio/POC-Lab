package com.alonso.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



import java.io.IOException;

@Service
public class KafkaConsumer {
	
	@Autowired
	KafkaSender kafkaSender;
	
	private static Logger logger = LoggerFactory.getLogger(KafkaConsumer.class);

    @KafkaListener(topics = "LabTopic_RawResult", groupId = "group_id")
    public void consume(String message) throws IOException {
    	
    	// Log information 
    	logger.info(String.format("#### -> message consumed from Kafka %s", message));

//        //Sending data to second Kafka Topic 
    	kafkaSender.send("LabTopic_ProcessResult", message);
  
    }
    

}


