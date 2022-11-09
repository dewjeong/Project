package file;


public class FileDTO { //4번째

	// 멤버변수 선언 ( fileInfo테이블의 컬럼들)
	private String filename; // 업로드한 파일의 원본이름
	private String filerealname; // 실제 업로드된 파일이름
	private int downloadCount; // 파일을 다운로드한 횟수 저장
	
	public FileDTO() {

	}
	
	public FileDTO(String filename, String filerealname) {
		this.filename = filename;
		this.filerealname = filerealname;
	}
	
	// FileDTO객체 생성시 위 filename, filerealname, downloadCount 인스턴스변수에 값을 초기화 시킬 생성자 (소스 메뉴 눌러서 만들면 됨)
	public FileDTO(String filename, String filerealname, int downloadCount) {
		// super(); -> 생략 가능 - super()는 상속받은 부모 클래스의 변수명이나 클래스 변수를 참조하고, 부모 클래스 생성자를 호출한다.
		this.filename = filename;
		this.filerealname = filerealname;
		this.downloadCount = downloadCount;
	}

	
	// getter, setter 만들기
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

	public int getDownloadCount() {
		return downloadCount;
	}

	public void setDownloadCount(int downloadCount) {
		this.downloadCount = downloadCount;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
