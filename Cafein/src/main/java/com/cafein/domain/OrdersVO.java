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
	private Date ordersdate;
	private Date deliverydate;
	
	// item 테이블
	private String itemname;

	// 검색용 변수
	
	// Criteria 객체
	private Criteria cri;	
	
}
