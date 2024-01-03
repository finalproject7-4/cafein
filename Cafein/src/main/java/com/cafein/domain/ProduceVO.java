package com.cafein.domain;


import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProduceVO {
	private Integer produceid;
	private Timestamp submitdate;
	private Date producedate;
	private int producetime;
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
	
	// 검색용 변수
	private Date startDate;
	private Date endDate;
	private String searchText;
	private String searchBtn;
	private String bigSearchBtn;

	// Criteria 객체
	private Criteria cri;


	
	
	
	
}
	