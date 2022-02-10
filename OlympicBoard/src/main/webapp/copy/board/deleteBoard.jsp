<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");

	String bidx = request.getParameter("bidx");
	
	Check check = new Check();
	
	ListPageData listPageData = (ListPageData)session.getAttribute("listPageData");
	String searchValue = null;
	String searchType = null;
	String nowPage = null;
	if(listPageData != null){
		searchType = listPageData.getSearchType();
		searchValue = listPageData.getSearchValue();
		nowPage = listPageData.getNowPage();
	}
	try {
		searchValue = URLEncoder.encode(searchValue, "UTF-8");
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "update board set bdelyn='Y' where bidx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,bidx);
		
		int result = psmt.executeUpdate();
		
		if(result > 0){
			check.setDeleteBoardCheck("success");
		}else{
			check.setDeleteBoardCheck("fail");
		}
		session.setAttribute("check",check);
		
		response.sendRedirect(request.getContextPath()+"/board/list.jsp?searchValue="+searchValue+"&searchType="+searchType+"&nowPage="+nowPage);
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}
%>