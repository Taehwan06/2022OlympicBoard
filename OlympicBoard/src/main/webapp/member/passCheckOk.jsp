<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	String url = request.getParameter("url");
	String pass = request.getParameter("memberpassword");

	Member loginUser = (Member)session.getAttribute("loginUser");

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	Check check = new Check();
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "select * from member where midx=? and memberpassword=?";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,loginUser.getMidx());
		psmt.setString(2,pass);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			if(url.equals("modify")){
				response.sendRedirect("memberModify.jsp");
			}else if(url.equals("withdraw")){
				response.sendRedirect("withdraw.jsp");
			}
		}else{
			if(url.equals("modify")){
				check.setPassCheck(true);
				session.setAttribute("check",check);
				response.sendRedirect("passCheck.jsp?url=modify");
			}else if(url.equals("withdraw")){
				check.setPassCheck(true);
				session.setAttribute("check",check);
				response.sendRedirect("passCheck.jsp?url=withdraw");
			}
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>