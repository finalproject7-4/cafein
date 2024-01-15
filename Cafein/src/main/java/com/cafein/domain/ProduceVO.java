package com.cafein.domain;


import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProduceVO {
	private Integer produceid;		// 생산 등록시 만들어지는 id 번호
	private String producecode;		// 생산등록시 만들 코드
	private Timestamp submitdate;	// 등록날짜
	private Date producedate;		// 생산날짜
	private Integer producetime;		// 생산시간대
	private Integer produceline;		// 생산라인
	private Integer itemid;				// 생산할 제품id
	private String itemname;		// 생산할 제품명
	private String process;			// 생산공정 종류
	private Integer temper;				// 로스팅때 적용할 온도
	private Integer itemid1;		// 원재료명 1
	private Integer itemid2;		// 원재료명 2
	private Integer itemid3;		// 원재료명 3
	private Integer amount;				// 생산량
	private Integer membercode;		// 담당사원 코드
	private String qualitycheck;	// 품질검사 상태
	private String state;			// 생산 상태
	private int packagevol;			// 포장 용량
	
	// 검색용 변수
	private String startDate;
	private String endDate;
	private String searchText;
	private String searchBtn;

	// Criteria 객체
	private Criteria cri;


	// 출고등록에 필요한 변수
		private Integer stockid;
		private Integer stockid1;
		private Integer stockid2;
		private Integer stockid3;
		private String rate;
	
	// stockVO
	private int stockquantity;
	
	// main 페이지 출력용
	private Integer todayAmount;
	private Integer thisYearAmount;
	private Integer thisMonthAmount;
	
	
	
}
	