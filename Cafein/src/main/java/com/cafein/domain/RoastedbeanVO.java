package com.cafein.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class RoastedbeanVO {

	private int productid;
	private int produceid;
	private String itemname;
	private int itemid;
	private int weight;

	private Date roasteddate;
	private String lotnumber;
	private String note;
	
	private String auditstatus;
	private String defect;
	
	
	private String roasteddate1;

	// Criteria 객체
		private Criteria cri;
		
	// 검색용 객체
		private String searchDate;
		private String searchLot;
	
}
