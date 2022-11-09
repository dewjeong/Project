package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// DB의 테이블과 연결하여 !!!!! DB작업하는 클래스 !!!!!
public class MemberDAO {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql;
	
	// 커넥션풀을 생성하고 커넥션풀 내부에 미리 연결을 맺은 Connection객체를 얻어 반환하는 메서드
	private Connection getConnection() throws Exception {
		
		// DB와 연결을 맺은 접속정보를 지닌 Connection객체를 저장할 변수
		Connection con = null;
		
		// 커넥션풀 얻기
			// 1) 자바의 네이밍 서비스(JNDI)에서 이름과 실제 객체를 연결해주는 역할을 하는
			//	  initialContext()객체를 생성하여 저장
			// 	  이 객체는 네이밍 서비스를 이용하기 위한 시작점이다
			//	  이 객체의 lookup()메서드에 이름을 건네 원하는 객체를 찾아올 수 있다.
			Context initCtx = new InitialContext();
			
			// 2) "java:comp/env"경로를 얻은 InitialContext객체를 얻는다.
			// 		여기서 "java:comp/env"경로는 현재 웹프로젝트의 루트 디렉토리 경로라 생각하면 된다.
			//		즉 현재 웹프로젝트 내부에서 사용할 수 있는 모든 자원은 "java:comp/env"경로에 위치한다.
			Context ctx = (Context)initCtx.lookup("java:comp/env");	// 다운캐스팅
			
			// 3) "java:comp/env"아래에 위치한 "dbcp_myoracle"자원을 얻어온다.
			//		이 자원이 바로 앞서 설정한 DataSource(커넥션풀)이다.
			//		여기서 "dbcp_myoracle"은 context.xml파일에 추가한 <ResourceLink>에 있는 name속성의 값이다.
			DataSource source = (DataSource)ctx.lookup("dbcp_myoracle"); // 다운캐스팅
			
			// 커넥션풀 내부에 저장되어 있는 커넥션 객체 얻기(DB연결)
			con = source.getConnection();
			
			return con;
		
		
		} // getConnection 끝
	
			// 연결 해제(자원반납)
			// DB관련 작업을 모두 마쳤다면 자원을 절약하기 위해 연결을 해제하는것이 좋다.
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
	
	
// DB에 member테이블에 회원가입 정보를 저장 INSERT할 메서드
		public int insertMember(MemberDTO memberdto) {
			
			int result = 0; // 회원가입 성공, 실패 여부값 저장 -> 1 또는 0
			
			try {

				con = getConnection();
				
				sql = "insert into member_1 (id, pass, name, address) values(?, ?, ?, ?)";

				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, memberdto.getId() );
				pstmt.setString(2, memberdto.getPass() );
				pstmt.setString(3, memberdto.getName() );
				pstmt.setString(4, memberdto.getAddress() );

				result = pstmt.executeUpdate();
				
				return result; // 1 또는 0 반환

			}catch (Exception e) {
				
				System.out.println("필수정보를 모두 입력해주세요!");
				e.printStackTrace();
			
			} finally {
				close();
			}
			return result;

		} // insertMember메서드 끝!
	
		
		// 회원가입을 위해 입력한 아이디가 DB에 저장되어 있는지 체크하는 메서드
		public int idCheck(String ID) {
			
			// 아이디 중복 또는 중복이 아니다 판별할 값 저장할 변수
			int idcheck = 0;
			
			try {
				con = getConnection();
				
				sql = "select * from member_1 where id=?";
				
				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, ID);
				
				rs = pstmt.executeQuery();
				
				// 조회된 행(레코드)이 존재하면 아이디 중복이므로 check변수값 1로 저장
				if(rs.next()) {
					idcheck = 1; // 아이디 중복o
					
				}else {
					idcheck = 0; // 아이디 중복x
				}
				
			}catch(Exception e){
				System.out.println("아이디 중복 확인 실패");
				e.printStackTrace();
				
			}finally {	
				close();
			}
			
			return idcheck;
			
		}// idCheck메서드 끝!
			
		// 매개변수로 입력한 아이디와 패스워드를 전달받아 DB의 아이디/패스워드와 일치하는 회원을 찾아 로그인하도록 하는 메서드
		public int userCheck(String id, String pass) {
			
			int check = -1; // 입력한 아이디 DB에 존재X
			
			try {

				con = getConnection();
				sql = "select * from member_1 where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) { // 입력한 아이디가 저장되어 있다면?
					
					if( pass.equals(rs.getString("pass")) ) { // 입력한 패스워드가 저장되어 있다면?
						
						check = 1; // 아이디, 패스워드 둘 다 존재O	
						
					}else { // 입력한 패스워드가 저장되어 있지 않다면?
						
						check = 0;	
					}
					
				}else {
					
					check = -1; // 아이디 존재X
					
				}
				
			} catch (Exception e) {
				
				System.out.println("userCheck메서드 내부에서 코드 오류: " + e);
				e.printStackTrace();
				
			}finally { // 무조건 한 번 실행되어야 할 코드 작성
				
				close();
			
			}	
			return check; // 1 or 0 or -1
		} // userCheck메서드 끝
		
		
		// 회원정보 수정칸에서 회원정보를 수정하는 메서드
		public int updateMember(MemberDTO dto) {
			
			int check = -1; 
			
			try {

				con = getConnection();
				
				sql = "update member_1 set pass=?, name=?, address=? where id=?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, dto.getPass());
				pstmt.setString(2, dto.getName());
				pstmt.setString(3, dto.getAddress());
				pstmt.setString(4, dto.getId());
				
				check = pstmt.executeUpdate(); // 행의 개수 반환
				
			} catch (Exception e) {
				
				System.out.println("updateMember메서드 내부에서 코드 오류: " + e);
				e.printStackTrace();
				
			}finally { // 무조건 한 번 실행되어야 할 코드 작성
				
				close();
			
			}	
			return check; // 수정성공하면 1, 실패하면 0
		
		} // updateMember메서드 끝
		
		
		// name값을 얻어 반환하는 메서드
		public String getName(String id) {
			
			String getname = "";
			
			try {

				con = getConnection();
				sql = "select * from member_1 where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery(); // 테이블 전체 가져옴
				
				if(rs.next()) { // 입력한 아이디가 저장되어 있다면?
					
					getname = rs.getString("name");
					
				}
				
			} catch (Exception e) {
				
				System.out.println("getName메서드 내부에서 코드 오류: " + e);
				e.printStackTrace();
				
			}finally { // 무조건 한 번 실행되어야 할 코드 작성
				
				close();
			
			}	
			return getname;
	
		} // getName 메서드 끝
		
} // DAO클래스 끝



