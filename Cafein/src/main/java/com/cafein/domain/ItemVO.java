package com.cafein.domain;

import lombok.Data;

@Data
public class ItemVO {

	// item 테이블
	private int itemid;
	private String itemcode;
	private String itemtype;
	private String itemname;
	private String clientcode;
	private String origin;
	private Integer itemweight;
	private int itemprice;
	private String available;
	
	// client 테이블
	private String clientname; // 거래처명
	
	// 검색용 변수
	private String option;
	private String keyword;
	
	// Criteria 객체
	private Criteria cri;
	
}
