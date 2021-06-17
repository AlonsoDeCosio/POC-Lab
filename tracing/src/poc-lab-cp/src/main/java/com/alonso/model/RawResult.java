package com.alonso.model;

import org.springframework.data.annotation.Id;


public class RawResult {

  @Id
  public String id;

  public String currency;
  public String latestInfo;

  public RawResult() {}

  public RawResult(String firstName, String lastName) {
    this.currency = firstName;
    this.latestInfo = lastName;
  }

  @Override
  public String toString() {
    return String.format(
        "Customer[id=%s, currency='%s', latestInfo='%s']",
        id, currency, latestInfo);
  }

}
