package com.cafein.domain;

/**
 * 페이징 처리에 필요한 정보를 저장한 객체
 * => 총 개수, 시작 페이지 번호, 끝 페이지 번호, 이전 링크, 다음 링크, 블럭의 크기 + Criteria (페이지번호, 페이지사이즈)
 *    1) 총 개수 : totalCount (DB 조회)
 *    2) 끝 페이지 번호 : endPage = 올림(현재 페이지 번호 / 블럭 크기) * 블럭 크기
 *    3) 시작 페이지 번호 : startPage = (endPage - 블럭의 크기) + 1
 *    4) 이전 페이지 링크 : prev (boolean) = startPage != 1
 *    5) 다음 페이지 링크 : next (boolean) = (endPage * pageSize) < totalCount
 */
public class PageVO {

		private int totalCount; // 총 개수
		private int startPage; // 페이지 블럭 시작 페이지 번호
		private int endPage; // 페이지 블럭 끝 페이지 번호
		
		private boolean prev; // 이전 링크
		private boolean next; // 다음 링크
		
		private int displayPageNum = 5; // 페이지 블럭 크기
		
		// private int page;
		// private int pageSize;
		private Criteria cri;
		
		// => 페이지 번호, 페이지 사이즈 저장
		public void setCri(Criteria cri) {
			this.cri = cri;
		}
		
		public void setTotalCount(int totalCount) {
			this.totalCount = totalCount;
			
			// 페이징 처리에 필요한 정보를 모두 계산
			calcData();
		}
		
		private void calcData() {
			// 페이징 처리에 필요한 정보를 모두 계산
			
			// 끝 페이지 번호
			endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum)) * displayPageNum;
			// 시작 페이지 번호
			startPage = (endPage - displayPageNum) + 1;
			
			// 끝 페이지 번호 체크 (글이 없는 경우)
//			int tmpEndPage = totalCount / cri.getPageSize() + (totalCount / cri.getPageSize() == 0? 0 : 1);
			int tmpEndPage = (int) Math.ceil((double) totalCount / cri.getPageSize());
			
			if(endPage > tmpEndPage) {
				endPage = tmpEndPage;
			}
			
			// 이전 링크
			prev = startPage != 1;
//			prev = (startPage == 1? true : false);
			
			// 다음 링크
			next = endPage * cri.getPageSize() < totalCount;
			
			// 페이징 처리에 필요한 정보 계산 완료
			
			
		} // calcData();
		
		
		
		
		
		// 기본 생성자 정의
		public PageVO() {
			// TODO Auto-generated constructor stub
		}

		// Getter, Setter 메서드 정의
		public int getTotalCount() {
			return totalCount;
		}

		public int getStartPage() {
			return startPage;
		}

		public void setStartPage(int startPage) {
			this.startPage = startPage;
		}

		public int getEndPage() {
			return endPage;
		}

		public void setEndPage(int endPage) {
			this.endPage = endPage;
		}

		public boolean isPrev() {
			return prev;
		}

		public void setPrev(boolean prev) {
			this.prev = prev;
		}

		public boolean isNext() {
			return next;
		}

		public void setNext(boolean next) {
			this.next = next;
		}

		public int getDisplayPageNum() {
			return displayPageNum;
		}

		public void setDisplayPageNum(int displayPageNum) {
			this.displayPageNum = displayPageNum;
		}

		public Criteria getCri() {
			return cri;
		}


		// toString 메서드 오버라이딩
		@Override
		public String toString() {
			return "PageVO [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
					+ prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", cri=" + cri + "]";
		}
		
}
