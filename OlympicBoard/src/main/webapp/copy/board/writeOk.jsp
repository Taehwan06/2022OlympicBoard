<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String bidx = request.getParameter("bidx");
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();		
		String sql = "insert into board(bidx,bsubject,bcontent,bwriter,midx) "
					+" values(bidx_seq.nextval,?,?,?,?)";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,subject);
		psmt.setString(2,content);
		psmt.setString(3,loginUser.getMembername());
		psmt.setInt(4,loginUser.getMidx());
		
		int result = psmt.executeUpdate();
		
		Check check = new Check();
		if(result>0){
			check.setWriteCheck(true);
			session.setAttribute("check",check);
		}
		response.sendRedirect(request.getContextPath()+"/board/list.jsp?bidx="+bidx);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}
%>