package com.cafein.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

/**
 * 보조기능(예외처리)를 구현한 객체 advice
 */
@ControllerAdvice
public class CommonExceptionAdvice {
	
	
	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionAdvice.class);

	@ExceptionHandler(Exception.class)
	public String CommonException(Exception e, Model model) {
		logger.debug("CommonException() 실행");
		
		e.printStackTrace();
		model.addAttribute("e", e);
		
		return "commons";
	}
}
