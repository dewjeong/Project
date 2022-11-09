package member;

import java.sql.Date;
public class MemberDTO { // 가입할 회원 또는 조회한 한 명의 회원정보를 저장시킬 클래스
		
		// 멤버변수 선언 (접근지정자는 꼭 private)
		private String id;       
		private String pass;       
		private String name;
		private String address;

		// 생성자 선언
		public MemberDTO() {} 

		public MemberDTO(String id, String pass, String name, String address){
			this.id = id;
			this.pass = pass;
			this.name = name;
			this.address = address;
		}

		// 멤버변수 별 getter와 setter메서드 선언
		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getPass() {
			return pass;
		}

		public void setPass(String pass) {
			this.pass = pass;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}
		

		public String getAddress() {
			return address;
		}

		public void setAddress(String name) {
			this.address = address;
		}

}	
