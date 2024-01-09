package com.cafein.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ReceiveVO {

	// receive 테이블
	private int receiveid;
	private String receivecode;
	private String orderscode;
	private int membercode;
	private int itemid;
	private String storagecode;
	private String lotnumber;
	private String receivestate;
	private Date receivedate;
	private int receivequantity;
	
	// orders 테이블
	private int ordersquantity;
	
	// item 테이블
	private String itemcode;
	private String itemname;
	
	// stock 테이블
	private int stockid;	
	private int stockquantity;
	
	// client 테이블
	private String clientname;
	
	// member 테이블
	private String membername;
	
	// storage 테이블
	private int storageid;
	private String storagename;
	
	// 검색용 변수
	private String option;
	private String keyword;
	private String receiveStartDate;
	private String receiveEndDate;
		
	// Criteria 객체
	private Criteria cri;		
	
}
