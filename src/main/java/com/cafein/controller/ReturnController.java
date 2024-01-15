package com.cafein.controller;

import java.time.LocalDate;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import com.cafein.domain.ReturnVO;
import com.cafein.service.ReturnService;

@Controller
@RequestMapping(value = "/quality/*")
public class ReturnController {

    private static final Logger logger = LoggerFactory.getLogger(ReturnController.class);

    @Inject
    private ReturnService rService;

    // http://localhost:8088/quality/returns
    @RequestMapping(value = "/returns", method = RequestMethod.GET)
    public void returnsGET(Model model) throws Exception{
    	
    	logger.debug("returnsGET() 호출");
    	
    	 List<ReturnVO> returnList = rService.searchReturns();
    	 model.addAttribute("returnList", returnList);
    }
    
    @RequestMapping(value = "/returns", method = RequestMethod.POST)
    public String returnsPost(@ModelAttribute("returnVO") ReturnVO returnVO, Model model) 
    		throws Exception{
    	
        logger.debug("returnsPost() 호출");


        List<ReturnVO> returnList = rService.searchReturnsByCondition(returnVO);
        model.addAttribute("returnList", returnList);

        return "redirect:/quality/returns";
    }
    

    // http://localhost:8088/quality/returnimp
    @RequestMapping(value = "/returnimp", method = RequestMethod.GET)
    public void returnimpGET(Model model) throws Exception{
    	
    	logger.debug("returnimpGET(Model model) 호출");
    	
    	 List<ReturnVO> returnList = rService.searchReturns();
    	 model.addAttribute("returnList", returnList);
    }
    
    
    
    
    
    
}