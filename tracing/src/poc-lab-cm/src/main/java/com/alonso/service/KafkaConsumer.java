package com.alonso.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

import com.alonso.repository.ProcessResultRepository;
import com.alonso.model.ProcessResult;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



import java.io.IOException;

@Service
public class KafkaConsumer {
	
	@Autowired
	private ProcessResultRepository myProcessResultRepository ;
	
	@Autowired
	KafkaSender kafkaSender;
	
	private static Logger logger = LoggerFactory.getLogger(KafkaConsumer.class);

    @KafkaListener(topics = "LabTopic_ProcessResult", groupId = "group_id")
    public void consume(String message) throws IOException {
    	
//    	// Getting all the data from Mongo
//        System.out.println(myPiceRepository.findAll());
        
        
    	// save kafka message on MongoDB
    	logger.info(String.format("#### -> message consumed from Kafka %s", message));
    	myProcessResultRepository.save(new ProcessResult("BTC", message));
    	
//    	// Getting all the data from Mongo 
//        System.out.println(myPiceRepository.findAll());
//        
//        //Sending data to second Kafka Topic 
//        kafkaSender.send("LabTopic2", message);
  
    }
    

}


