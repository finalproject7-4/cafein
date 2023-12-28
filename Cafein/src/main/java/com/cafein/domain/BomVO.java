package com.cafein.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BomVO {
	
	private int bomid;
	private Timestamp submitdate;
	private String itemcode;
	private String itemname1;
	private String itemname2;
	private String itemname3;
	private int temper;
	private String rate;
	private int roastedtime;
	private String membercode;
	
	private String itemname;
}
