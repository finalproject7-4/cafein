package com.cafein.security;

import org.springframework.security.crypto.password.PasswordEncoder;

/**
 *  시큐리티-JDBC 연결 테스트를 위한 임시 암호화 객체
 *  (실제 암호화 동작 X)
 *  @@@@@@@@@@ 이 페이지가 필요한지 확인하기 @@@@@@@@@@@
 * */
public class CustomNoopPasswordEncoder implements PasswordEncoder {

	// alt shift s -> v (override)
	@Override
	public String encode(CharSequence rawPassword) {
		// 암호화 동작 수행
		// ex) a -> egj78 
		return rawPassword.toString(); // 암호화 안하고 그냥 넘기기만 합니다.
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		// 암호화된 비밀번호를 기존의 비밀번호와 비교
		return rawPassword.equals(encodedPassword);
	}

	
}
