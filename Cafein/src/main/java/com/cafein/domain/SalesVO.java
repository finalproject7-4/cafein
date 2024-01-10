package com.cafein.domain;

import java.sql.Date;


import lombok.Data;

@Data
public class SalesVO {
	
	// Criteria 객체
	private Criteria cri;
	
	// 검색용 변수
	private String startDate;
	private String endDate;
	private String searchText;
	private String searchBtn;
	private String option;
	private String keyword;
	
	//po 테이블
	private int poid;
	private String postate;
	private String pocode;
	private int clientid;
	private int itemid;
	private int pocnt;
	private Date ordersdate;
	private Date updatedate;
	private Date ordersduedate;
	private int membercode;
	
	//client 테이블
	private String clientcode; // 거래처코드
	private String clientname; // 거래처명
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
	
	//member
	private String membername;
	private String cafeinNumber;
	private String cafeinName;
	private String cafeinRepresent;
	private String cafeinAddr;
	private String cafeinFax;
	private String cafeinCall;
	private String memberphone;
	private String departmentname;
	private String memberposition;
	private String memberemail;

	
	// ship 테이블
	private String lotnumber; //LOT번호
	
	@Override
	public String toString() {
		return "SalesVO [poid=" + poid + ", postate=" + postate + ", pocode=" + pocode + ", clientid=" + clientid
				+ ", itemid=" + itemid + ", pocnt=" + pocnt + ", ordersdate=" + ordersdate + ", updatedate="
				+ updatedate + ", ordersduedate=" + ordersduedate + ", membercode=" + membercode + "]";
	}


	

}
