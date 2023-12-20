package com.cafein.domain;

import java.sql.Timestamp;

import lombok.Data;


@Data
public class SalesVO {
	// Value Object  => DTO 개념으로 사용 (디비 테이블정보를 저장하는 객체)
	
	//테이블의 정보를 저장
	private int poid;
	private String postate;
	private String pocode;
	private int clientid;
	private int itemid;
	private int pocnt;
	private Timestamp ordersdate;
	private Timestamp updatedate;
	private Timestamp ordersduedate;
	private String membercode;

}
