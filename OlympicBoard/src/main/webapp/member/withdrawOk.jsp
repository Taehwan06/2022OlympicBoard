<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	Check check = new Check();
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "update member set delyn='Y' where midx=?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,loginUser.getMidx());
		
		int result = psmt.executeUpdate();
		
		if(result>0){
			check.setWithdraw("success");
			session.setAttribute("check",check);
			session.setAttribute("loginUser",null);
			response.sendRedirect(request.getContextPath());
		}else{
			check.setWithdraw("fail");
			session.setAttribute("check",check);
			response.sendRedirect("mypage.jsp");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>