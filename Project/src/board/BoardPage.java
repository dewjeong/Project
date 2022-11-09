// 페이지 처리

package board;

// 페이지 바로가기 영역을 HTML문자열로 출력해주는 기능의 메서드가 작성된 클래스
public class BoardPage {

	public static String pagingStr(int totalCount, int pageSize, int blockPage, int pageNum, String redUrl){
		
		String pagingStr = "";
		
		// 3
		int totalPages = (int)(Math.ceil ( totalCount / pageSize) );
		
		// 이전페이지의 블럭 바로 가기
		//계산식 : ( (현재 페이지 - 1 ) / PAGES_PER_BLOCK ) * PAGES_PER_BLOCK    + 1
		// 4
		int pageTemp = (( (pageNum - 1) / blockPage ) * blockPage) + 1;
		
		if(pageTemp != 1) { // 1페이지가 아닐때만 출력
			
			pagingStr += "<a href='" +	redUrl + "?pageNum=1'>[◁◁]</a>"; 
			
			pagingStr += "&nbsp;";
			
			pagingStr += "<a href='" + redUrl + "?pageNum=" + (pageTemp-1) +"'>[◀]</a>";
			
		}
		
		// 5
		int blockCount = 1;
		
		while(blockCount <= blockPage && pageTemp <= totalPages) {
			
			if(pageTemp == pageNum) {
				pagingStr += "&nbsp;" + pageTemp + "&nbsp;";
				
			}else {
				
				pagingStr += "&nbsp;<a href='" + redUrl + "?pageNum=" + pageTemp + "'>"+ pageTemp + "</a>&nbsp;";
				
			}
			
			pageTemp++;
			blockCount++;

		}
		
		// 6
		if(pageTemp <= totalPages) { // 마지막페이지가 아닐때만 출력
			
			pagingStr += "<a href='" +	redUrl + "?pageNum=" + pageTemp + "'>[▶]</a>";
			
			pagingStr += "&nbsp;";
			
			pagingStr += "<a href='" + redUrl + "?pageNum=" + totalPages +"'>[▷▷]</a>";
						
		}

		return pagingStr;
	} // 메서드 끝
} // 클래스 끝
