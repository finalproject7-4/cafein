package com.cafein.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;


@Data
public class ShipVO {
	
	// Criteria 객체
	private Criteria cri;
	
	// 검색용 변수
	private String startDate;
	private String endDate;
	private String searchText;
	private String searchBtn;
	
	// 출하
	private int shipid;
	private String shipcode;
	private int pocnt;
	private String shipsts;
	private Date shipdate1;
	private Date shipdate2;
	
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
	
	// work 테이블
	private int workid;
//	private String membercode;
	private Date workdate1;
	private Date workdate2;
	private String worksts;
	private int workcount;
	private Date workupdate;
	private String workcode;

//	private String pocode;
	private int receiptid;

//	private String clientcode;
	private int recordcount;
	private String returncode;
	
	// 거래처
	private int clientid;
//	private String clientcode;
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
	
	// 멤버 테이블
	private int memberid;
	private int membercode;
	private String membername;
	private String memberpw;
	private Date memberbirth;
	private Date memberhire;
	private Timestamp memberupdate;
	private String departmentname;
	private String memberposition;
	private String memberemail;
	private String memberdeptphone;
	private String memberphone;
//	private String available;
	
}