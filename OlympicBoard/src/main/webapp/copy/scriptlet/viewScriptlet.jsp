<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");

	String bidx = request.getParameter("bidx");	
	String nowPage = request.getParameter("nowPage");
	
	ListPageData listPageData = (ListPageData)session.getAttribute("listPageData");
	String searchValue = null;
	String searchType = null;
	if(listPageData != null){
		searchType = listPageData.getSearchType();
		searchValue = listPageData.getSearchValue();		
	}
		
	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	Check check = (Check)session.getAttribute("check");
	
	Notice notice = new Notice();
	
	Cookie[] cookieHCA = request.getCookies();
	
	Board board = (Board)session.getAttribute("board");
	ArrayList<Reply> rList = new ArrayList<>();

	String value = "";
	String[] valueA = null;
	boolean hitCheck = false;
	if(cookieHCA != null){
		for(Cookie cookieHC : cookieHCA){
			if(cookieHC.getName().equals("hitCheck")){
				value = cookieHC.getValue();
				valueA = value.split("&");
				for(int i=0; i<valueA.length; i++){
					if(valueA[i].equals(bidx)){
						hitCheck = true;
					}
				}
			}
		}
	}	
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		String sql = "";
		
		if(!hitCheck){
			sql = "update board set bhit=((select bhit from board where bidx=?)+1) where bidx=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,bidx);
			psmt.setString(2,bidx);
			
			int reault = psmt.executeUpdate();
			if(reault>0){
				Cookie cookieHC = new Cookie("hitCheck", value+bidx+"&");
				cookieHC.setMaxAge(60*60);
				response.addCookie(cookieHC);
			}
		}
		
		sql = "select * from board where bidx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,bidx);		
		
		rs = psmt.executeQuery();		
		
		if(rs.next()){
			board.setBidx(rs.getInt("bidx"));
			board.setMidx(rs.getInt("midx"));
			board.setBhit(rs.getInt("bhit"));
			board.setRecnt(rs.getInt("recnt"));
			board.setBwriter(rs.getString("bwriter"));
			board.setBsubject(rs.getString("bsubject"));
			board.setBcontent(rs.getString("bcontent"));
			board.setBwdate(rs.getString("bwdate"));
			board.setUp(rs.getInt("up"));
			session.setAttribute("board",board);
		}		
				
		sql = "select * from reply where bidx=? order by ridx";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,bidx);
		
		rs = psmt.executeQuery();
			
		while(rs.next()){
			Reply reply = new Reply();
			reply.setRidx(rs.getInt("ridx"));
			reply.setBidx(rs.getInt("bidx"));
			reply.setMidx(rs.getInt("midx"));
			reply.setRwriter(rs.getString("rwriter"));
			reply.setRwdate(rs.getString("rwdate"));
			reply.setRcontent(rs.getString("rcontent"));
			reply.setRdelyn(rs.getString("rdelyn"));
			
			rList.add(reply);
		}
			
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);		
	}
%>