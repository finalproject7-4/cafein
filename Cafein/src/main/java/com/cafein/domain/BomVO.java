package com.cafein.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BomVO {
	
	private Integer bomid;
	private Timestamp submitdate;
	private String itemcode;
	private Integer itemid;
	private Integer itemid1;
	private Integer itemid2;
	private Integer itemid3;
	private Integer temper;
	private String rate;
	private Integer roastedtime;
	private String membercode;
	
	// 필요할 수도 있어서 DB에는 없지만 추가 정의
	private String itemname;
	private String itemname1;
	private String itemname2;
	private String itemname3;
}
