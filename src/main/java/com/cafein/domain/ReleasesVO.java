package com.cafein.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReleasesVO {

	private int releaseid;
	private String releasecode;
	private String membercode;
	private int stockid;
	private Timestamp releasedate;
	private int releasequantity;
	
}
