package com.alonso.model;

import org.springframework.data.annotation.Id;


public class ProcessResult {

  @Id
  public String id;

  public String currency;
  public String latestInfo;

  public ProcessResult() {}

  public ProcessResult(String firstName, String lastName) {
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
