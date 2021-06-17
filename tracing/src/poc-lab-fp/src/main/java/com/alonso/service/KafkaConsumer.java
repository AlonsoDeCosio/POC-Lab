package com.alonso.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

import com.alonso.repository.PiceRepository;
import com.alonso.tasks.SendMessageTask;
import com.alonso.model.Price;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



import java.io.IOException;

@Service
public class KafkaConsumer {
	
	@Autowired
	private PiceRepository myPiceRepository ;
	
	@Autowired
	KafkaSender kafkaSender;
	
	private static Logger logger = LoggerFactory.getLogger(KafkaConsumer.class);

    @KafkaListener(topics = "LabTopic", groupId = "group_id")
    public void consume(String message) throws IOException {
    	
//    	// Getting all the data from Mongo
//    	System.out.println("Getting data'):");
//        System.out.println("--------------------------------");
//        System.out.println(myPiceRepository.findAll());
        
        
    	// save kafka message on MongoDB
    	logger.info(String.format("#### -> message consumed from Kafka %s", message));
//    	myPiceRepository.save(new Price("BTC", message));
    	
//    	// Getting all the data from Mongo 
//    	System.out.println("Getting Latest data'):");
//        System.out.println("--------------------------------");
//        System.out.println(myPiceRepository.findAll());
//        
//        //Sending data to second Kafka Topic 
//        kafkaSender.send("LabTopic2", message);
  
    }
    

}


