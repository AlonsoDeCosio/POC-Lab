package com.alonso.tasks;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.concurrent.ExecutionException;

import com.alonso.service.KafkaSender;

import com.alonso.repository.PiceRepository;
import com.alonso.model.Price;

import com.alonso.repository.RawResultRepository;
import com.alonso.model.RawResult;

import com.alonso.repository.ProcessResultRepository;
import com.alonso.model.ProcessResult;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Component
public class SendMessageTask {
	@Autowired
	KafkaSender kafkaSender;
	
	@Autowired
	private PiceRepository myPiceRepository ;
	
	@Autowired
	private RawResultRepository myRawResultRepository ;
	
	@Autowired
	private ProcessResultRepository myProcessResultRepository ;
	
	private static Logger logger = LoggerFactory.getLogger(SendMessageTask.class);
	

    // run every 3 sec
    @Scheduled(fixedRateString = "3000")
    public void send() throws ExecutionException, InterruptedException {
    	
    	String message  = String.valueOf(Math.random());
    	kafkaSender.send("LabTopic_RawResult", message);
    	
//    	myPiceRepository.save(new Price("BTC", message));
    	myRawResultRepository.save(new RawResult("BTC", message));
//    	myProcessResultRepository.save(new ProcessResult("BTC", message));
    	
    	
    	logger.info(String.format("#### -> message palce to Kafka %s", message));
    	logger.info(String.format("#### -> saved in mongo"));
    }
}
