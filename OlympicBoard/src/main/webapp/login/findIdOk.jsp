<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String phone = phone1+"-"+phone2+"-"+phone3;
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	Check check = new Check();
	
	try{
		conn = DBManager.getConnection();
		String sql = "select * from member where membername=? and phone=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,name);
		psmt.setString(2,phone);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			response.sendRedirect("findIdSuccess.jsp?id="+rs.getString("memberid")+"&email="+rs.getString("email"));
		}else{
			check.setIdCheck("fail");
			session.setAttribute("check",check);
			response.sendRedirect("findId.jsp");
		}	
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}	
%>