package com.cafein.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;


@Data
public class ShipVO {
	
	// 출하
	private int shipid;
	private String shipcode;
	private int shipcount;
	private String shipsts;
	private Date shipdate;
	
	private String pocode;
	
	// stock 테이블
	private int stockid;
	private int qualityid;
//	private String itemtype;
//	private int itemid;
	private int stockquantity;
	private int storageid;
	private Date registerationdate;
	private String workerbycode;
	private Date updatedate;
	private String updatehistory;
	private int nowquantity;
	private String nowstorage;
	
	private String membercode;
	private String lotnumber;
	
	// item 테이블
	private int itemid;
	private String itemcode;
	private String itemtype;
	private String itemname;
	private String clientcode;
	private String origin;
	private int itemweight;
	private int itemprice;
	private String available;
	private String workcode;
	
}