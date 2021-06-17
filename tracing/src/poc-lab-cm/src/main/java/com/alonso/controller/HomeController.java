package com.alonso.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController

public class HomeController {
	
//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public String home() {
//		return "Use any of the following endpoints: /livenessProbe, /book, /book/{id}, /book/add, /add/employee, /remove/employee";
//	}
	
	@RequestMapping(value = "/livenessProbe", method = RequestMethod.GET, produces="application/json")
	public String livenessProbe() {
		return "{\"State\": \"Healthy\", \"Message\": \"Everything is working\"}";
	}

}
