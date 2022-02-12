<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null || !loginUser.getGrade().equals("A")){
		response.sendRedirect(request.getContextPath());
	}
	
	String midx = request.getParameter("midx");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String grade = request.getParameter("grade");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String phone = phone1+"-"+phone2+"-"+phone3;	
	String birth1 = request.getParameter("birth1");
	String birth2 = request.getParameter("birth2");
	String birth3 = request.getParameter("birth3");
	String birth = birth1+"년"+birth2+"월"+birth3+"일";
	
	Check check = new Check();
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();		
		String sql ="update member set membername=?, email=?, phone=?, birth=?, grade=? where midx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,name);
		psmt.setString(2,email);
		psmt.setString(3,phone);
		psmt.setString(4,birth);
		psmt.setString(5,grade);
		psmt.setString(6,midx);
		
		int result = psmt.executeUpdate();
		if(result>0){			
			check.setMemberModify("success");
		}else{
			check.setMemberModify("fail");
		}
		session.setAttribute("check",check);
		response.sendRedirect("memberView.jsp?midx="+midx);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}
%>