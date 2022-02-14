package OlympicBoard.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Board {
	private int bidx;
	private int midx;
	private String bwriter;
	private String bcontent;
	private String bwdate;
	private String bsubject;
	private String bnotice;
	private String bdelyn;
	private int bhit;
	private int recnt;
	private int up;
	private String bimgsys;
	private String bimgori;
	
	
	public String getBimgsys() {
		return bimgsys;
	}
	public void setBimgsys(String bimgsys) {
		this.bimgsys = bimgsys;
	}
	public String getBimgori() {
		return bimgori;
	}
	public void setBimgori(String bimgori) {
		this.bimgori = bimgori;
	}
	public int getUp() {
		return up;
	}
	public void setUp(int up) {
		this.up = up;
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
	public String getBwriter() {
		return bwriter;
	}
	public void setBwriter(String bwriter) {
		this.bwriter = bwriter;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	public String getBwdate() throws ParseException {
		Date date = null;
		try {
			date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(bwdate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String outdate = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분ss초").format(date);
		
		return outdate;
	}
	public void setBwdate(String bwdate) {
		this.bwdate = bwdate;
	}
	public String getBsubject() {
		return bsubject;
	}
	public void setBsubject(String bsubject) {
		this.bsubject = bsubject;
	}
	public String getBnotice() {
		return bnotice;
	}
	public void setBnotice(String bnotice) {
		this.bnotice = bnotice;
	}
	public String getBdelyn() {
		return bdelyn;
	}
	public void setBdelyn(String bdelyn) {
		this.bdelyn = bdelyn;
	}
	public int getBhit() {
		return bhit;
	}
	public void setBhit(int bhit) {
		this.bhit = bhit;
	}
	public int getRecnt() {
		return recnt;
	}
	public void setRecnt(int recnt) {
		this.recnt = recnt;
	}
}
