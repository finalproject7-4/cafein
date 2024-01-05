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

	private int receiptid;

//	private String clientcode;
	private int returncount;
	private String returnreason;
	
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
//	private String available;
//	private String workcode;
	
	//po 테이블
	private int poid;
	private String postate;
	private String pocode;
//	private int clientid;
//	private int itemid;
	private int pocnt;
	private Date ordersdate;
	private Date updatedate;
	private Date ordersduedate;
//	private String membercode;
	
	// 거래처 테이블
	private int clientid;
	private String clientcode;
	private String clientname;
	private String categoryofclient;
	private String typeofclient;
	private String businessnumber;
	private String representative;
	private String manager;
	private String clientaddress;
	private String clientphone;
	private String clientfax;
	private String clientemail;
	private String available;
	
	// stock 테이블
	private int stockid;
//	private int qualityid;
//	private String itemtype;
//	private int itemid;
	private String lotnumber;
	private int stockquantity;
	private int storageid;
	private Date registerationdate;
	private String workerbycode;
//	private Date updatedate;
	private String updatehistory;
	private int nowquantity;
	private String nowstorage;

}
