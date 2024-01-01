package com.cafein.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BomVO {
	
	private int bomid;
	private Timestamp submitdate;
	private String itemcode;
	private String itemname1;
	private String itemname2;
	private String itemname3;
	private int temper;
	private String rate;
	private int roastedtime;
	private String membercode;
	
	// 필요할 수도 있어서 DB에는 없지만 추가 정의
	private String itemname;
	private int itemid;
}
