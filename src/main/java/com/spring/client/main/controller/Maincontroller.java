package com.spring.client.main.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Controller
public class Maincontroller {
	final static Logger Logger= LoggerFactory.getLogger(Maincontroller.class);
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String main() {
		return "index";
	}
}
