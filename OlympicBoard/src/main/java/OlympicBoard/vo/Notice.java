package OlympicBoard.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Notice {

	private String listWritedate;
	private String viewWritedate;
	private String replyWritedate;
		
	
	public String getReplyWritedate() throws ParseException {
		Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(replyWritedate);		
		
		String outdate = new SimpleDateFormat("MM-dd HH:mm").format(date);
		
		return outdate;
	}

	public void setReplyWritedate(String replyWritedate) {
		this.replyWritedate = replyWritedate;
	}

	public String getListWritedate() throws ParseException {
		Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(listWritedate);		
		
		String outdate = new SimpleDateFormat("MM-dd HH:mm").format(date);
		
		return outdate;
	}

	public void setListWritedate(String listWritedate) {
		this.listWritedate = listWritedate;
	}

	public String getViewWritedate() throws ParseException {
		Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(viewWritedate);		
		
		String outdate = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분ss초").format(date);
		
		return outdate;
	}

	public void setViewWritedate(String viewWritedate) {
		this.viewWritedate = viewWritedate;
	}
}
