<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String bidx = request.getParameter("bidx");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	ListPageData listPageData = (ListPageData)session.getAttribute("listPageData");
	String searchValue = null;
	String searchType = null;
	String nowPage = null;
	if(listPageData != null){
		searchType = listPageData.getSearchType();
		searchValue = listPageData.getSearchValue();
		nowPage = listPageData.getNowPage();
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		String sql = "update board set bsubject=?, bcontent=? where bidx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,subject);
		psmt.setString(2,content);
		psmt.setString(3,bidx);
		
		int result = psmt.executeUpdate();
		
		Check check = new Check();
		if(result > 0){
			check.setModifyCheck("success");			
		}else{
			check.setModifyCheck("fail");			
		}
		session.setAttribute("check",check);
		response.sendRedirect(request.getContextPath()+"/board/view.jsp?bidx="+bidx);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}
	
%>