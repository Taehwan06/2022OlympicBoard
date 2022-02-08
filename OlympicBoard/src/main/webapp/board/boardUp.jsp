<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");	
	String bidx = request.getParameter("bidx");
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	int midx = loginUser.getMidx();
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();	
		
		String sql = "update board set up=((select up from board where bidx=?)+1) where bidx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,bidx);
		psmt.setString(2,bidx);
		
		int result = psmt.executeUpdate();
		String value = "";
		
		if(result>0){
			sql = "select * from member where midx=?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,midx);
			rs = psmt.executeQuery();
			
			if(rs.next()){
				value = rs.getString("uplist");
			}
			value += "&"+bidx;
			
			sql = "update member set uplist=? where midx=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,value);
			psmt.setInt(2,midx);
			result = psmt.executeUpdate();
		}
		
		Member m = new Member();
		if(result>0){
			m.setUplist(value);
			m.setMemberid(loginUser.getMemberid());
			m.setMemberpassword(loginUser.getMemberpassword());
			m.setMembername(loginUser.getMembername());
			m.setPhone(loginUser.getPhone());
			m.setEmail(loginUser.getEmail());
			m.setBirth(loginUser.getBirth());
			m.setEnterdate(loginUser.getOriginEnterdate());
			m.setMidx(loginUser.getMidx());
			m.setOriginEnterdate(loginUser.getOriginEnterdate());
			
			session.setAttribute("loginUser",m);
		}
				
		out.print(result);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}
%>