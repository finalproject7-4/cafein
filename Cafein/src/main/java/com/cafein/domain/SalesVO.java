package com.cafein.domain;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SalesVO {
	
	//po 테이블
	private Criteria cri;
	private int poid;
	private String postate;
	private String pocode;
	private int clientid;
	private int itemid;
	private int pocnt;
	private Date ordersdate;
	private Date updatedate;
	private Date ordersduedate;
	private String membercode;
	
	//client 테이블
	private String clientcode; // 거래처코드
	private String clientname; // 거래처명
	private String categoryofclient; // 거래처구분
	private String businessnumber; // 사업자번호
	private String representative; //대표자
	private String clientaddress; //주소
	private String clientphone; //전화번호
	private String clientfax; //팩스번호
	
	//item 테이블
	private String itemcode; //품목코드
	private String itemname; //품명
	private String origin; // 원산지
	private int itemweight;//중량
	private int itemprice; //단가
	
	// ship 테이블
	private String lotnumber; //LOT번호
	
	@Override
	public String toString() {
		return "SalesVO [poid=" + poid + ", postate=" + postate + ", pocode=" + pocode + ", clientid=" + clientid
				+ ", itemid=" + itemid + ", pocnt=" + pocnt + ", ordersdate=" + ordersdate + ", updatedate="
				+ updatedate + ", ordersduedate=" + ordersduedate + ", membercode=" + membercode + "]";
	}


}
