package com.cafein.domain;

import java.sql.Timestamp;

import lombok.Data;


@Data
public class ShipVO {
	
	// 출하
	private int shipid;
	private String shipcode;
	private int shipcount;
	private String shipsts;
	private Timestamp shipsdate;
	
	private String pocode;
	private int stockid;
	private String membercode;
	private String lotnumber;
	
	
	
}