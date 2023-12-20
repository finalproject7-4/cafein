package com.cafein.domain;

import java.sql.Timestamp;

import lombok.Data;


@Data
public class SalesVO {
	// Value Object  => DTO 개념으로 사용 (디비 테이블정보를 저장하는 객체)
	
	//po 테이블
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

	//client 테이블
	private String clientname; // 거래처명
	private String categoryofclient; // 거래처구분
	private String businessnumber; // 사업자번호
	private String representative; //대표자
	private String clientaddress; //주소
	private String clientphone; //전화번호
	private String clientfax; //팩스번호
	
	//item 테이블
	private String itemname; //품명
	private String origin; // 원산지
	private int itemweight;//중량
	private int itemprice; //단가
	
	// ship 테이블
	private String lotnumber; //LOT번호
	
}
