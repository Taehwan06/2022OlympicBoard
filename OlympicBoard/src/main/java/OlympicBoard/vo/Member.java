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
	private String originEnterdate;
	private int midx;
	private String uplist;
	private String grade;
	private String breakdate;
	private String delyn;
	private String originBreakdate;
	
	
	public String getOriginBreakdate() {
		return originBreakdate;
	}
	public void setOriginBreakdate(String originBreakdate) {
		this.originBreakdate = originBreakdate;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
	public String getBreakdate() {
		String outdate = null;
		if(breakdate != null) {
			Date date = null;
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(breakdate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			outdate = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분ss초").format(date);
		}else {
			outdate = "탈퇴하지 않은 회원입니다.";
		}
		return outdate;
	}
	public void setBreakdate(String breakdate) {
		this.breakdate = breakdate;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getOriginEnterdate() {
		return originEnterdate;
	}
	public void setOriginEnterdate(String originEnterdate) {
		this.originEnterdate = originEnterdate;
	}
	public String getUplist() {
		return uplist;
	}
	public void setUplist(String uplist) {
		this.uplist = uplist;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEnterdate() {
		Date date = null;
		try {
			date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(enterdate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String outdate = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분ss초").format(date);
		
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
