package com.alonso.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.alonso.model.ProcessResult;

public interface ProcessResultRepository extends MongoRepository<ProcessResult, String> {

  public ProcessResult findByCurrency(String currency);
  public List<ProcessResult> findByLatestInfo(String latestInfo);

}