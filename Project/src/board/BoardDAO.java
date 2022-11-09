
package board;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// DB의 테이블들과 연결하여 DB작업하는 클래스
public class BoardDAO {

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
		} 
	
    // 연결 해제(자원반납)
	public void close() {
		
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close(); // 커넥션풀로 Connect객체 사용 후 반납
			
			System.out.println("커넥션풀 공간에 Connection객체 사용 후 반납");
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	
	// 검색 조건에 맞는 게시물의 개수를 반환하는 메서드
	public int selectCount(Map<String, Object> map) {
		
		int totalCount = 0;
		
		try {
			con = getConnection();
			
			sql = "select count(*) from board_1";
			
			if(map.get("searchWord") != null) {
				
				sql += " where " +  map.get("searchField") + " "
						+ " LIKE '%" + map.get("searchWord") + "%'";
				
			}
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next(); 

			totalCount = rs.getInt(1);
			
		}catch(Exception e){
			
			System.out.println("selectCount메서드 내부에서 SQL실행오류" + e);
			
		}finally {
			
			close();
		}

		return totalCount; 
	}
	
	
	// 삭제할 글번호를 매개변수로 받아서 DB의 board_1테이블에 저장된 글번호에 해당되는 글을 삭제하는 메서드
	public int deletePost(String num) {
		
		int result = 0;
		
		try {
			
			con = getConnection();
			
			sql = "delete from board_1 where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, num);
			
			// result에 저장 -> Update는 int로 반환되기 때문에!
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("deletePost메서드 내부에서 오류");
			e.printStackTrace();	
			
		} finally {
			close();
		}
		
		return result;
	}
	
	
	// board_1테이블의 글정보(레코드)를 조회해서 가져와 반환하는 메서드
	public List selectList(Map<String, Object> map) {
		
		List<BoardDTO> bbs = new Vector<BoardDTO>();
		
		try {

			con = getConnection();
			
			sql = "select * from ("
				+	"		SELECT Tb.*, rownum rNum FROM ( "
				+	"		SELECT * FROM board_1 ";		
			
			
			if(map.get("searchWord") != null) {
				
				sql += " where " +  map.get("searchField") + " "
						+ " LIKE '%" + map.get("searchWord") + "%'";
				
			}
				
			 	sql += " ORDER BY num DESC"
			 			+ " )Tb"
			 			+ ") "
			 			+ " WHERE rNum BETWEEN ? and ?";
			 
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, map.get("start").toString() );
			pstmt.setString(2, map.get("end").toString() );
			
			rs = pstmt.executeQuery();			
			
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				String num = rs.getString("num"); 
				String title = rs.getString("title"); 
				String id = rs.getString("id"); 
				Date postDate = rs.getDate("postdate"); 
				String visitcount = rs.getString("visitcount"); 
				String content = rs.getString("content"); 
				
				dto.setNum(num);
				dto.setTitle(title);
				dto.setId(id);
				dto.setPostdate(postDate);
				dto.setVisitcount(visitcount);
				dto.setContent(content);
				
				bbs.add(dto);	
			}
			
		}catch(Exception e) {
			
			System.out.println("selectList메서드 내부에서 오류:" + e);
			
		}finally {
			
			close();	
		}
		return bbs;
	}
	

	// board_1테이블에 저장된 글의 조회수 증가시키는 메서드 
	public void updateVisitCount(String num) {
		
		try {

			con = getConnection();
			
			sql = "update board_1 set visitcount=visitcount+1 where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			
			System.out.println("updateVisitCount에서 오류" + e);
			e.printStackTrace();
			
		}finally {
			close();	
		} 
	}
	
	
	// 매개변수로 전달받은 글번호에 해당하는 글의 정보를 member_1테이블과 board_1테이블을 join하여 검색해오는 메서드
	public BoardDTO selectView(String num) {
		
		BoardDTO dto = new BoardDTO();
		
		try {
			
			con = getConnection();
			
			sql = "select B.*, M.name"
					+ " from member_1 M INNER JOIN board_1 B "
					+ " ON M.id=B.id "
					+ " where num=?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, num);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {

				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setId(rs.getString("id"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setName(rs.getString("name"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilerealname(rs.getString("filerealname"));
			}
			
		}catch(Exception e) {
			
			System.out.println("selectView메서드 내부에서 오류: " + e);
			e.printStackTrace();
		
		}finally {

			close();
		}
		return dto; 
	} 
	
	
	// writePro.jsp를 통해 글작성을 해주는 메서드
	public void insertBoard(BoardDTO dto) {
		
		try {
			con = getConnection();
																	// 처음에 visitcount(조회수)는 무조건 0
			sql = 	"insert into board_1(num, title, content, id, postdate, visitcount, pass, filename, filerealname)"
					+ " values(seq_board_1_num.nextval,    ?,      ?,  ?, sysdate,          0, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			// 물음표 설정
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getId());
			pstmt.setString(4, dto.getPass());
			pstmt.setString(5, dto.getFilename());
			pstmt.setString(6, dto.getFilerealname());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			
			System.out.println("insertBoard메서드 내부에서 오류: " + e);
			e.printStackTrace();
			
			
		}finally {
			
			close();
		} 
	} 
	
	
	// 글번호를 넘겨 수정할 글을 선택해주는 메서드
	public int updateBoard(BoardDTO dto) {
		
		int check = 0;
		
		try {
			con = getConnection();
			
			sql = "select pass from board_1 where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				if(dto.getPass().equals(rs.getString("pass"))) {
					check = 1;
					
					sql = "update board_1 set title=?, content=?, postdate=sysdate, filename=?, filerealname=? where num=?";
					
					pstmt=con.prepareStatement(sql);
					
					pstmt.setString(1, dto.getTitle());
					pstmt.setString(2, dto.getContent());
					pstmt.setString(3, dto.getFilename());
					pstmt.setString(4, dto.getFilerealname());
					pstmt.setString(5, dto.getNum());
					
					pstmt.executeUpdate();
					
				}else {
					
					check = 0;		
				}
			} // 바깥쪽 if
			
		} catch (Exception e) {
			
			System.out.println("updateBoard메서드 내부에서 오류: " + e);
			e.printStackTrace();
			
		} finally {
			
			close();
		}
			return check;
	} // updateBoard 메서드 끝
	
	
	
} // BoardDAO클래스 끝

