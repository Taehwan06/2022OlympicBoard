package OlympicBoard.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Notice {

	private String listWritedate;
	private String viewWritedate;
	private String replyWritedate;
		
	
	public String getReplyWritedate() {
		Date date = null;
		try {
			date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(replyWritedate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		String outdate = new SimpleDateFormat("MM-dd HH:mm").format(date);
		
		return outdate;
	}

	public void setReplyWritedate(String replyWritedate) {
		this.replyWritedate = replyWritedate;
	}

	public String getListWritedate() {
		Date date = null;
		try {
			date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(listWritedate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		String outdate = new SimpleDateFormat("MM-dd HH:mm").format(date);
		
		return outdate;
	}

	public void setListWritedate(String listWritedate) {
		this.listWritedate = listWritedate;
	}

	public String getViewWritedate() {
		Date date = null;
		try {
			date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(viewWritedate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		String outdate = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분").format(date);
		
		return outdate;
	}

	public void setViewWritedate(String viewWritedate) {
		this.viewWritedate = viewWritedate;
	}
}
