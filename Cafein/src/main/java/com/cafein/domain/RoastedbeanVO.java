package com.cafein.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class RoastedbeanVO {

	private int productid;
	private int produceid;
	private String itemname;
	private int itemid;
	private int weight;
	private int itemprice;
	private Date roasteddate;
	private String lotnumber;
	private String note;

	
}
