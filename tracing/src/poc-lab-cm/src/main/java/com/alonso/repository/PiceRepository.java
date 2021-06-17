package com.alonso.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.alonso.model.Price;

public interface PiceRepository extends MongoRepository<Price, String> {

  public Price findByCurrency(String currency);
  public List<Price> findByLatestInfo(String latestInfo);

}