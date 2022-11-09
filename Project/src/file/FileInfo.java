package file;  // FileDAO의 upload()에서 오버라이딩 할 수 있도록 인터페이스 3번째

import java.util.ArrayList;

// FileDAO.java에서 오버라이딩(implements)하여 사용할 추상메서드가 있는 인터페이스
public interface FileInfo {

	// 서버경로에 실제로 업로드된 파일명과 원본파일명을 매개변수로 받아 fileInfo테이블에 insert시킬 추상 메서드
	public int upload(String fileName, String fileRealName);
	
	// 다운로드할 파일명들을 DB로부터 검색해서 가져와 각각 행 단위로 FileDTO객체에 저장 후
	// 최종적으로 ArrayList배열에 담아 반환할 추상메서드
	public ArrayList<FileDTO> AllSelect(); // 검색해오는 메서드
	
	// 사용자가 파일을 다운로드 할 때마다 다운로드한 횟수를 fileInfo테이블에 UPDATE시킬 추상메서드 생성
	// 단 다운로드한 파일의 실제이름을 매개변수로 전달받아 사용하자
	public int hit(String filerealName);
	

}
