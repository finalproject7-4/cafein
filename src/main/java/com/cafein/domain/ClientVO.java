package com.cafein.domain;

import lombok.Data;

@Data
public class ClientVO {
	
	private int clientid;
	private String clientcode;
	private String clientname;
	private String categoryofclient;
	private String typeofclient;
	private String businessnumber;
	private String representative;
	private String manager;
	private String clientaddress;
	private String clientphone;
	private String clientfax;
	private String clientemail;
	private String available;

}
