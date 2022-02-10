<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	Member loginUser = (Member)session.getAttribute("loginUser");

	String pass = request.getParameter("pass");	
	String email = request.getParameter("email");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String phone = phone1+"-"+phone2+"-"+phone3;
	
	Check check = new Check();
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();		
		String sql ="update member set memberpassword=?, email=?, phone=? where midx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,pass);
		psmt.setString(2,email);
		psmt.setString(3,phone);
		psmt.setInt(4,loginUser.getMidx());
		
		int result = psmt.executeUpdate();
		if(result>0){			
			check.setMemberModify("success");
			session.setAttribute("check",check);
			response.sendRedirect("mypage.jsp");
		}else{
			check.setMemberModify("fail");
			session.setAttribute("check",check);
			response.sendRedirect("mypage.jsp");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}
%>