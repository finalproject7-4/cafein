package com.cafein.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class OrdersVO {

	// orders 테이블
	private int ordersid;
	private String orderscode;
	private String membercode;
	private String itemcode;
	private int ordersquantity;
	private String orderstate;
	private Date ordersdate;
	private Date deliverydate;
	
	// item 테이블
	private String itemname;
	
	// member 테이블
	private String membername;
	
	// client 테이블
	private String clientname;
	
	// 발주 금액
	private int ordersprice;

	// 검색용 변수
	private String option;
	private String keyword;
	private Date orderStartDate;
	private Date orderEndDate;
	private Date deliveryStartDate;
	private Date deliveryEndDate;
	
	// Criteria 객체
	private Criteria cri;	
	
}
