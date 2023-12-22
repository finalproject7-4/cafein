package com.cafein.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrdersVO {

	private int ordersid;
	private String orderscode;
	private String membercode;
	private String itemcode;
	private int ordersquantity;
	private Timestamp ordersdate;
	private Timestamp deliverydate;
	
}
