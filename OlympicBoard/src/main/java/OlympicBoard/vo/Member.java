package OlympicBoard.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Member {

	private String memberid;
	private String memberpassword;
	private String membername;	
	private String phone;
	private String birth;
	private String email;
	private String enterdate;
	private int midx;
			

	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEnterdate() throws Exception {	
		Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(enterdate);
		
		String outdate = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분").format(date);
		
		return outdate;
	}
	public void setEnterdate(String enterdate) {
		this.enterdate = enterdate;
	}
	public int getMidx() {
		return midx;
	}
	public void setMidx(int midx) {
		this.midx = midx;
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getMemberpassword() {
		return memberpassword;
	}
	public void setMemberpassword(String memberpassword) {
		this.memberpassword = memberpassword;
	}
	public String getMembername() {
		return membername;
	}
	public void setMembername(String membername) {
		this.membername = membername;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
		
}
