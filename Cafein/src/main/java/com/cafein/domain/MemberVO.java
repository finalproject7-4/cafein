package com.cafein.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberVO {
	
	private int memberid;
	private int membercode;
	private String membername;
	private String memberpw;
	private String memberbirth;
	private String memberhire;
	private Timestamp memberupdate;
	private String departmentname;
	private String memberposition;
	private String memberemail;
	private String memberdeptphone;
	private String memberphone;
	private String available;
	
	// 검색용 객체
	private String option;
	private String keyword;
	
	// Criteria 객체
	private Criteria cri;
	
}