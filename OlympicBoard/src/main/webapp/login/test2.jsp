<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%@ page import= "java.security.SecureRandom"%>
<%@ page import= "java.util.Date"%>
<%
	int midx = 5;
	String email = "lth-mail@nate.com";
	
	String password = "asdfqwer";
	
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;

	try{
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		String sql = "update member set memberpassword=? where midx=?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,password);
		psmt.setInt(2,midx);
		
		int result = psmt.executeUpdate();
		
		if(result>0){
			response.sendRedirect("login.jsp");
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn!=null) conn.close();
		if(psmt!=null) psmt.close();		
	}
%>
