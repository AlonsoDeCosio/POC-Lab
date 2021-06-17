package com.alonso.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.alonso.model.RawResult;

public interface RawResultRepository extends MongoRepository<RawResult, String> {

  public RawResult findByCurrency(String currency);
  public List<RawResult> findByLatestInfo(String latestInfo);

}