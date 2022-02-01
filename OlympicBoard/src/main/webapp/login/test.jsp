<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String name = "이지은";
	String id = "user03";
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String phone = "010-0003-0003";
	String email = "lth-mail@nate.com";
		
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	Check check = new Check();
	
	try{
		conn = DBManager.getConnection();
		String sql = "select * from member where membername=? and memberid=? and phone=? and email=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,name);
		psmt.setString(2,id);
		psmt.setString(3,phone);
		psmt.setString(4,email);
		
		rs = psmt.executeQuery();		
		
		if(rs.next()){
			response.sendRedirect("sendMailPass.jsp?midx="+rs.getInt("midx")+"&email="+email);			
		}		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>