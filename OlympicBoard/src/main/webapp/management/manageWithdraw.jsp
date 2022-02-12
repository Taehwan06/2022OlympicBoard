<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String midx = request.getParameter("midx");

	Member loginUser = (Member)session.getAttribute("loginUser");
	
	if(loginUser == null || !loginUser.getGrade().equals("A")){
		response.sendRedirect(request.getContextPath());
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	Check check = new Check();
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "update member set delyn='Y' where midx=?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,midx);
		
		int result = psmt.executeUpdate();
		
		if(result>0){
			
			sql = "update member set breakdate=sysdate where midx=?";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,midx);
			
			psmt.executeUpdate();
			
			check.setWithdraw("success");
		}else{
			check.setWithdraw("fail");
		}
		session.setAttribute("check",check);
		response.sendRedirect(request.getContextPath()+"/management/memberView.jsp?midx="+midx);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>