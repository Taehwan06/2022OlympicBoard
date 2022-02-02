<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	String midx = request.getParameter("midx");

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "select * from (select count(*) c from board where midx=?)";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,midx);
		
		rs = psmt.executeQuery();
		
		out.print(rs.getInt("c"));		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>