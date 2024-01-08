package com.cafein.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ReleasesVO {

	// releases 테이블
	private int releaseid;
	private String releasecode;
	private String producecode;
	private String membercode;
	private int itemid;
	private int stockid;
	private String releasestate;
	private Date releasedate;
	private int releasequantity;
	private int produceid;
	
	// item 테이블
	private String itemname;
	private int itemid;
	
	// stock 테이블
	private int stockquantity;
	
	// member 테이블
	private String membername;
	
	// 검색용 변수
	private String option;
	private String keyword;
	private String releaseStartDate;
	private String releaseEndDate;
		
	// Criteria 객체
	private Criteria cri;
	
}
