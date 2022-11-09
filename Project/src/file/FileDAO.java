package file;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Vector;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import board.BoardDTO;

public class FileDAO implements FileInfo {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql;
	
	
	// 커넥션풀을 생성하고 커넥션풀 내부에 미리 연결을 맺은 Connection객체를 얻어 반환하는 메서드
	private Connection getConnection() throws Exception {
		
		Connection con = null;
		
			Context initCtx = new InitialContext();
			
			Context ctx = (Context)initCtx.lookup("java:comp/env");	// 다운캐스팅
			
			DataSource source = (DataSource)ctx.lookup("dbcp_myoracle"); // 다운캐스팅
			
			con = source.getConnection();
			
			return con;
			
	} // getConnection 끝
	
	
	// close메서드는 DB관련 작업 객체의 자원을 해제하는 메서드다.
	public void close() {
		
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close(); // 커넥션풀로 Connect객체 사용 후 반납
			
			System.out.println("커넥션풀 공간에 Connection객체 사용 후 반납");
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
	} // close메서드 끝

	
	// 메서드 오버라이딩
/*
	 
 	메소드 오버라이딩이란?
 	
 	- 상속관계에서 부모클래스의 메소드의 선언부(메소드명, 리턴타입, 매개변수)를
 	  자식클래스에 모두 동일하게 작성하되, 
 	  부모클래스의 메소드의 { 구현부 }를 자식클래스의 기능에 맞게 재정의 하는 기술	
 
 	- 자식클래스에서 부모클래스와 동일한 이름의 메소드를 새롭게 정의해서
 	  부모클래스로부터 상속받은 메소드를 더이상 사용하지 않고
 	  자식클래스에서 새롭게 정의한 메소드를 사용하도록 하는것입니다.
 
 */
	
	// fileInfo테이블에 INSERT하는 기능의 메서드
	@Override
	public int upload(String fileName, String fileRealName) { // 5번째 
		
		try {
			// DB와의 연결
			con = getConnection();	
			
			// SQL문 작성
			sql = "insert into fileInfo_1(fileName, fileRealName, downloadCount)" // 컬럼명 생략 가능함
							+ " values  (?,            ?,            0)";
			
			// preparedStatment 객체 얻기
			pstmt = con.prepareStatement(sql);
			
			// '?'설정
			pstmt.setString(1, fileName); // 원본파일명
			pstmt.setString(2, fileRealName); // 실제 업로드파일명
			
			// INSERT구문 실행 후 결과 얻기
			return pstmt.executeUpdate(); // 성공하면 1(행의 개수)반환   ---> fileUploadAction.jsp
	
		}catch(Exception e){
			
			e.printStackTrace();
			
		}finally {
			
			close();
			
		}

		return -1; // insert에 실패하면 -1을 반환
	}

	// 다운로드할 파일명들을 DB의 fileInfo테이블로부터 검색해서 가져와
	// 검색한 한 줄씩 FileDTO객체에 각각 저장 후 ArrayList배열에 담아 변환하는 메서드
	@Override
	public ArrayList<FileDTO> AllSelect() { // 7번째
		
		ArrayList<FileDTO> list = new ArrayList<FileDTO>();
		
		sql = "select * from fileInfo_1";
		
		try {
			
			con = getConnection();
			
			pstmt = con.prepareStatement(sql);
			
						// 테이블 채로 가져옴
			rs = pstmt.executeQuery(); // 실행된 결과
			
			while(rs.next()) {
				
				// 조회된 레코드(하나의 행, 하나의 글정보)를 저장시킬 FileDTO객체 생성 (DTO생성자의 매개변수를 이용하면 따로 setter메서드 호출할 필요X)
				FileDTO dto = new FileDTO(rs.getString("filename"), rs.getString("filerealname"), rs.getInt("downloadCount"));
				
				// ResultSet객체에서 조회된 글의 정보를 하나씩 꺼내와서 FileDTO객체 생성 시 각 인스턴스변수에 저장
				
				/* 기본생성자를 호출해서! 이렇게 적어도 되나 위와 같은 방식을 사용하면 소스 길이가 줄어든다.
				  	dto.setFilename(rs.getString("filename"));
				  	dto.setFilename(rs.getString("filerealname"));
				  	dto.setDownloadCount(rs.getInt("downloadCount"));
				 */
				
				// Vector배열에 FileDTO객체 추가
				list.add(dto);	
			}
			
			
		}catch(Exception e) {
			
			e.printStackTrace();
			
		}finally {
		
			close();
			
		}
	
		return list; // fileDownloadList.jsp페이지로 반환
	}
	
	// 사용자가 파일다운로드 할 때마다 다운로드한 횟수를 DB에 업데이트 하기위한 메서드
	@Override
	// 다운로드한 파일의 실제이름을 매개변수로 전달
	public int hit(String filerealName) { // 9번째
		
		// 사용자가 파일다운로드 할 때마다 다운로드한 파일의 횟수를 1증가 시키는 update문 작성
		sql = "update fileInfo_1 set downloadcount=downloadcount+1"
				+ " where filerealname=?";
		
		try {
			con = getConnection();
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, filerealName);
			
			return pstmt.executeUpdate(); // 1(행의 개수)반환
			
		}catch(Exception e) {
			
			e.printStackTrace();
			
		}finally {
			
			close();
			
		}
			
		return -1; // 파일 다운로드 횟수 증가시키기에 실패하면 -1을 반환한다.
	}

	
}
