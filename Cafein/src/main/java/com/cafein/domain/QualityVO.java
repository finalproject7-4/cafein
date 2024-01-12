package com.cafein.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class QualityVO {
	
	// quality 테이블
	private int qualityid;
	private String auditcode;
	private String itemtype;
	private int produceid;
	private String produceprocess;
	private int returnid;
	private int itemid;
	private int auditbycode;
	private int productquantity;
	private int auditquantity;
	private int normalquantity;
	private int defectquantity;
	private String auditstatus;
	private Date registerationdate;
	private Date completedate;
	private String registerstock;
	private String registerdefect;
	
	// defects 테이블
	private int defectid;
//	private int qualityid;
	private String defecttype;
	private String processmethod;
//	private Timestamp registerationdate;
	
	// stock 테이블
	private int stockid;
//	private int qualityid;
//	private String itemtype;
//	private int itemid;
	private int stockquantity;
	private int storageid;
//	private Timestamp registerationdate;
	private int workerbycode;
	private Date updatedate;
	private String updatehistory;
	private int nowquantity;
	private String nowstorage;
	
	// item 테이블
//	private int itemid;
	private String itemcode;
//	private String itemtype;
	private String itemname;
	private String clientcode;
	private String origin;
	private int itemweight;
	private int itemprice;
	private String available;
	
	// produce 테이블
//	private int produceid;
	private Timestamp submitdate;
	private Date producedate;
	private int produceline;
//	private int itemid;
//	private String itemname;
	private String process;
	private int temper;
	private String itemname1;
	private String itemname2;
	private String itemname3;
	private int amount;
	private int membercode;
	private String qualitycheck;
	private String state;
	
	// storage 테이블
//	private int storageid;
	private String storagename;
	private String storagecode;
	private String storagetype;
	private String lotnumber;
//	private String membercode;
	
	// roastedbean 테이블
	private int productid;
//	private int produceid;
//	private String itemname;
//	private int itemid;
	private int weight;
//	private int itemprice;
	private Date roasteddate;
//	private Sting lotnumber;
	private String note;
	private String defect;
	
	// receive 테이블
	private int receiveid;
	private String receivecode;
//	private String membercode;
	private Date receivedate;
	private int receivequantity;
	
	// productlot 테이블
	private int productlotid;
//	private int produceid;
//	private int receiveid;
//	private String lotnumber;
	
	// return 테이블
	private String reprocessmethod;
	private String returnstatus;
	private String returninfo;
	
	private String returncode;
	private int returnquantity;
	
	// 검색용 특별 변수
	private String startDate;
	private String endDate;
	private String searchText;
	private String searchBtn;
	
	// 구분용 특별 변수
	private String type;
	
	// Criteria 객체
	private Criteria cri;
	
}
