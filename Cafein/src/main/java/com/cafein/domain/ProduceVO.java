package com.cafein.domain;


import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProduceVO {
	private Integer produceid;		// 생산 등록시 만들어지는 id 번호
	private Timestamp submitdate;	// 등록날짜
	private Date producedate;		// 생산날짜
	private int producetime;		// 생산시간대
	private int produceline;		// 생산라인
	private int itemid;				// 생산할 제품id
	private String itemname;		// 생산할 제품명
	private String process;			// 생산공정 종류
	private int temper;				// 로스팅때 적용할 온도
	private String itemname1;		// 원재료명 1
	private String itemname2;		// 원재료명 2
	private String itemname3;		// 원재료명 3
	private int amount;				// 생산량
	private String membercode;		// 담당사원 코드
	private String qualitycheck;	// 품질검사 상태
	private String state;			// 생산 상태
	private int packagevol;			// 포장 용량
	
	// 검색용 변수
	private Date startDate;
	private Date endDate;
	private String searchText;
	private String searchBtn;

	// Criteria 객체
	private Criteria cri;


	
	
	
	
}
	