package com.alonso.model;

import org.springframework.data.annotation.Id;


public class Price {

  @Id
  public String id;

  public String currency;
  public String latestInfo;

  public Price() {}

  public Price(String firstName, String lastName) {
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
