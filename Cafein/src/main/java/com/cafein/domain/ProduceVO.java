package com.cafein.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProduceVO {
	private Integer produceid;
	private Timestamp submitdate;
	private Timestamp producedate;
	private int produceline;
	private int itemid;
	private String itemname;
	private String process;
	private int temper;
	private String itemname1;
	private String itemname2;
	private String itemname3;
	private int amount;
	private String membercode;
	private String qualitycheck;
	private String state;
	
	
}
