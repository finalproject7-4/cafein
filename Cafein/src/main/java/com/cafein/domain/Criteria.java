package com.cafein.domain;

/**
 * 페이징 처리를 위해서 생성한 객체
 * => 페이지 번호, 페이지 사이즈를 저장하는 객체
 *
 */

public class Criteria {
	
	private int page;
	private int pageSize;
	
	// 기본 생성자 정의
	public Criteria() {
		this.page = 1;
		this.pageSize = 10;
	}
	
	// Getter, Setter 메서드 정의 - Alt + Shift + S -> R
	public int getPage() {
		return page;
	}
	public int getPageSize() {
		return pageSize;
	}
	
	// private int startPage; // 변수 선언 없이 get 메서드만 구현
	// 변수는 없지만, mapper에서 사용 - #{startPage} 요소 호출
	public int getStartPage() {
		// 페이지 정보 -> 쿼리 사용되는 값 (시작 인덱스)으로 변경
		
		return (this.page - 1) * pageSize;
	}
	
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return; // 함수 종료
		}
		this.page = page;
	}
	public void setPageSize(int pageSize) {
		if(pageSize <= 0 || pageSize > 100) {
			this.pageSize = 10;
			return; // 함수 종료
		}
		this.pageSize = pageSize;
	}
	
	// toString 메서드 오버라이딩 - Alt + Shift + S -> S
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", pageSize=" + pageSize + "]";
	}
	

}
