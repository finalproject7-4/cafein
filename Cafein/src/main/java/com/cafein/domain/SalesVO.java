package com.cafein.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class SalesVO {
	
	//po 테이블
	private int poid;
	private String postate;
	private String pocode;
	private int clientid;
	private int itemid;
	private int pocnt;
	private Timestamp ordersdate;
	private Timestamp updatedate;
	private Timestamp ordersduedate;
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

	public int getPoid() {
		return poid;
	}

	public void setPoid(int poid) {
		this.poid = poid;
	}

	public String getPostate() {
		return postate;
	}

	public void setPostate(String postate) {
		this.postate = postate;
	}

	public String getPocode() {
		return pocode;
	}

	public void setPocode(String pocode) {
		this.pocode = pocode;
	}

	public int getClientid() {
		return clientid;
	}

	public void setClientid(int clientid) {
		this.clientid = clientid;
	}

	public int getItemid() {
		return itemid;
	}

	public void setItemid(int itemid) {
		this.itemid = itemid;
	}

	public int getPocnt() {
		return pocnt;
	}

	public void setPocnt(int pocnt) {
		this.pocnt = pocnt;
	}

	public Timestamp getOrdersdate() {
		return ordersdate;
	}

	public void setOrdersdate(Timestamp ordersdate) {
		this.ordersdate = ordersdate;
	}

	public Timestamp getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Timestamp updatedate) {
		this.updatedate = updatedate;
	}

	public Timestamp getOrdersduedate() {
		return ordersduedate;
	}

	public void setOrdersduedate(Timestamp ordersduedate) {
		this.ordersduedate = ordersduedate;
	}

	public String getMembercode() {
		return membercode;
	}

	public void setMembercode(String membercode) {
		this.membercode = membercode;
	}

	public String getClientcode() {
		return clientcode;
	}

	public void setClientcode(String clientcode) {
		this.clientcode = clientcode;
	}

	public String getClientname() {
		return clientname;
	}

	public void setClientname(String clientname) {
		this.clientname = clientname;
	}

	public String getCategoryofclient() {
		return categoryofclient;
	}

	public void setCategoryofclient(String categoryofclient) {
		this.categoryofclient = categoryofclient;
	}

	public String getBusinessnumber() {
		return businessnumber;
	}

	public void setBusinessnumber(String businessnumber) {
		this.businessnumber = businessnumber;
	}

	public String getRepresentative() {
		return representative;
	}

	public void setRepresentative(String representative) {
		this.representative = representative;
	}

	public String getClientaddress() {
		return clientaddress;
	}

	public void setClientaddress(String clientaddress) {
		this.clientaddress = clientaddress;
	}

	public String getClientphone() {
		return clientphone;
	}

	public void setClientphone(String clientphone) {
		this.clientphone = clientphone;
	}

	public String getClientfax() {
		return clientfax;
	}

	public void setClientfax(String clientfax) {
		this.clientfax = clientfax;
	}

	public String getItemcode() {
		return itemcode;
	}

	public void setItemcode(String itemcode) {
		this.itemcode = itemcode;
	}

	public String getItemname() {
		return itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public int getItemweight() {
		return itemweight;
	}

	public void setItemweight(int itemweight) {
		this.itemweight = itemweight;
	}

	public int getItemprice() {
		return itemprice;
	}

	public void setItemprice(int itemprice) {
		this.itemprice = itemprice;
	}

	public String getLotnumber() {
		return lotnumber;
	}

	public void setLotnumber(String lotnumber) {
		this.lotnumber = lotnumber;
	}
	
	
}
