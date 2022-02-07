<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String bidx = request.getParameter("bidx");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	Notice notice = new Notice();
	
	Cookie[] cookieHCA = request.getCookies();

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
	Connection conn2 = null;
	PreparedStatement psmt2 = null;
	ResultSet rs2 = null;
	
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
			notice.setViewWritedate(rs.getString("bwdate"));
			
			conn2 = DBManager.getConnection();
			String sql2 = "select * from reply where bidx=?";
			psmt2 = conn2.prepareStatement(sql2);
			psmt2.setString(1,bidx);
			
			rs2 = psmt2.executeQuery();
%>