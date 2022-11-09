package board;

import java.sql.Date;

public class BoardDTO {

	// 멤버변수 선언
	
	private String pass; // 글 비밀번호
    private String num; // 글번호
    private String title; // 글제목
    private String content; // 글내용
    private String id; // 글 작성자ID
    private Date postdate; // 글 작성일
    private String visitcount; // 글 조회수
    private String name; // 글 작성자명
    private String filename;
    private String filerealname;
    
    // 참고) board테이블에는 작성자의 ID만 저장되므로 글목록을 DB에서 조회하면 이름은 출력되지 않는다.
    //		이름을 출력하려면 member테이블과 join해야한다. 이 때 name열을 사용하게 된다.
    //		DTO클래스는 필요한경우 다른 테이블의 컬럼을 멤버변수로 추가할 수 있다.
    
    // 기본생성자 자동으로 만들어주기 때문에 생략
    
    // getter, setter 메서드 선언 

	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getPostdate() {
		return postdate;
	}
	public void setPostdate(Date postdate) {
		this.postdate = postdate;
	}
	public String getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFilerealname() {
		return filerealname;
	}
	public void setFilerealname(String filerealname) {
		this.filerealname = filerealname;
	}

	
	
	
	
}
