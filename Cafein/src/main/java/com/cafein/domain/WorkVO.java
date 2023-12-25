package com.cafein.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class WorkVO {
	
	// 작업지시+실적
	private int workid;
	private String membercode;
	private Date workdate1;
	private Date workdate2;
	private String worksts;
	private int workcount;
	private Date workupdate;
	private String workcode;
	private String itemcode;
	private String pocode;
	private int receiptid;
	private int produceid;
	private String clientcode;
	private int recordcount;
	private String returncode;

}
