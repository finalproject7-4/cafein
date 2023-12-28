package com.cafein.domain;

/**
 *	페이징 처리를 위해서 생성한 객체
 *	페이지 번호, 페이지 사이즈를 저장하는 객체
 */
public class Criteria {
	
	private int page;
	private int pageSize;
	
	// default 값 설정
	public Criteria() {
		this.page = 1;
		this.pageSize = 10;
	}
	
	// Alt + Shift + R
	
	// set -> 페이지를 설정
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
		
	}
	
	public void setPageSize(int pageSize) {
		if(pageSize <= 0 || pageSize > 100) {
			this.pageSize = 10;
			return;
		}
		this.pageSize = pageSize;
		
	}
	
	public int getPage() {
		return page;
	}
	public int getPageSize() {
		return pageSize;
	}
	
	// 별도의 변수 선언 필요 없이 get 메서드만 구현
	// 변수는 없지만 mapper 에서 사용됨 #{startPage} 요소 호출
	public int getStartPage() {
		// 입력된 페이지 정보 -> 쿼리에서 사용되는 값으로 변경
		return (this.page - 1) * pageSize;
	}
	
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", pageSize=" + pageSize + "]";
	}
	
}
