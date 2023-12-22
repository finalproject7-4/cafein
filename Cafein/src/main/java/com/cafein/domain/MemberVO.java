package com.cafein.domain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberVO {
	
	private int memberid;
	private String membercode;
	private String membername;
	private String memberpw;
	private Date memberbirth;
	private Date memberhire;
	private Timestamp memberupdate;
	private String departmentname;
	private String memberposition;
	private String memberemail;
	private String memberdeptphone;
	private String memberphone;
	private String available;

}
