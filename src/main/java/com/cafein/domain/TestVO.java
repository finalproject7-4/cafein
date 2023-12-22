package com.cafein.domain;

import lombok.Data;


@Data
public class TestVO {
	// Value Object  => DTO 개념으로 사용 (디비 테이블정보를 저장하는 객체)
	
	//테이블의 정보를 저장
	private int bno;
	private String userid;
	private String userpw;
	private String username;
	private String useremail;

}
