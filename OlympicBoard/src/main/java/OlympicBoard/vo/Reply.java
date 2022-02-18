package OlympicBoard.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Reply {
	private int ridx;
	private int bidx;
	private int midx;
	private String rcontent;
	private String rwriter;
	private String rwdate;
	private String rmdate;
	private String rddate;
	private String rdelyn;
	private int lvl;
	
	
	public String getRddate() {
		String outdate = "";
		if(rddate != null) {
			Date date = null;
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(rddate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			outdate = new SimpleDateFormat("yy-MM-dd HH:mm:ss").format(date);
		}else {
			outdate = "null";
		}
		return outdate;
	}
	public void setRddate(String rddate) {
		this.rddate = rddate;
	}
	public String getRmdate() {
		String outdate = "";
		if(rmdate != null) {
			Date date = null;
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(rmdate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			outdate = new SimpleDateFormat("yy-MM-dd HH:mm:ss").format(date);
		}else {
			outdate = "null";
		}
		return outdate;
	}
	public void setRmdate(String rmdate) {
		this.rmdate = rmdate;
	}
	public int getLvl() {
		return lvl;
	}
	public void setLvl(int lvl) {
		this.lvl = lvl;
	}
	public String getRdelyn() {
		return rdelyn;
	}
	public void setRdelyn(String rdelyn) {
		this.rdelyn = rdelyn;
	}
	public int getRidx() {
		return ridx;
	}
	public void setRidx(int ridx) {
		this.ridx = ridx;
	}
	public int getBidx() {
		return bidx;
	}
	public void setBidx(int bidx) {
		this.bidx = bidx;
	}
	public int getMidx() {
		return midx;
	}
	public void setMidx(int midx) {
		this.midx = midx;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public String getRwriter() {
		return rwriter;
	}
	public void setRwriter(String rwriter) {
		this.rwriter = rwriter;
	}
	public String getRwdate() throws ParseException {
		Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(rwdate);
		
		String outdate = new SimpleDateFormat("yy-MM-dd HH:mm").format(date);
		
		return outdate;
	}
	public void setRwdate(String rwdate) {
		this.rwdate = rwdate;
	}
}
