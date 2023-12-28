package com.cafein.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class WorkVO {
	
	// 작업지시+실적
	private int workid;
	private String membercode;
	private Date workdate1;
	private Date workdate2;
	private String worksts;
	private int workcount;
	private Date workupdate;
	private String workcode;

	private String pocode;
	private int receiptid;

	private String clientcode;
	private int recordcount;
	private String returncode;
	
	// produce 테이블
	private Integer produceid;
	private Date submitdate;
	private Date producedate;
	private int produceline;
	private String process;
	private int temper;
	private String itemname1;
	private String itemname2;
	private String itemname3;
	private int amount;
	private String qualitycheck;
	private String state;
	
	
	// item 테이블
	private int itemid;
	private String itemcode;
	private String itemtype;
	private String itemname;
//	private String clientcode;
	private String origin;
	private int itemweight;
	private int itemprice;
	private String available;
//	private String workcode;

}
