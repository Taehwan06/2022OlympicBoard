<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String ridx = request.getParameter("ridx");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();	
		
		String sql = "update reply set rdelyn='Y' where ridx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,ridx);
				
		int result = psmt.executeUpdate();
				
		out.print(ridx);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}
%>