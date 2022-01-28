<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String passcheck = request.getParameter("passcheck");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String birth1 = request.getParameter("birth1");
	String birth2 = request.getParameter("birth2");
	String birth3 = request.getParameter("birth3");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql ="select * from board where memberid=?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,id);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			response.sendRedirect("join.jsp?idcheck=false");
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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>joinOk.jsp 입니다</h2>
</body>
</html>