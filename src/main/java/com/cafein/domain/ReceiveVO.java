package com.cafein.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReceiveVO {

	private int receiveid;
	private String receivecode;
	private String membercode;
	private String itemcode;
	private String storagecode;
	private String lotnumber;
	private Timestamp receivedate;
	private int receivequantity;
	
}
