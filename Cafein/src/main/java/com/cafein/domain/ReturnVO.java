package com.cafein.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ReturnVO {
    // 테이블의 정보를 저장
    private int returnid;
    private int qualityid;
    private String returncode;
    private Date returndate;
    private Date exchangedate;
    private Date submitdate;
    private String returnstatus;
    private int returnquantity;
    private String reprocessmethod;
    private int returnprice;
    private String returntype;
    
    private Date startDate;
	private Date endDate;
    
    
    
    
    
    

	


    
    
    
    
}