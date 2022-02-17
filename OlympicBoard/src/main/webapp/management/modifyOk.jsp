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
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String searchValue = request.getParameter("searchValue");
	String searchType = request.getParameter("searchType");
	String nowPage = request.getParameter("nowPage");
	String notice = request.getParameter("notice");
	
	ListPageData listPageData = new ListPageData();
	if(session.getAttribute("listPageData") != null){
		listPageData = (ListPageData)session.getAttribute("listPageData");
	}
	
	if(listPageData != null && listPageData.getSearchType() != null && listPageData.getSearchValue() != null){
		searchType = listPageData.getSearchType();
		searchValue = listPageData.getSearchValue();		
	}	
	
	if(listPageData != null && listPageData.getNowPage() != null){		
		nowPage = listPageData.getNowPage();
	}
	
	ReUrl reurl = (ReUrl)session.getAttribute("ReUrl");
	
	if(searchValue != null){
		try {
			searchValue = URLEncoder.encode(searchValue, "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}else{
		if(!loginUser.getGrade().equals("A")){
			response.sendRedirect(request.getContextPath());
		}else{
	
			Connection conn = null;
			PreparedStatement psmt = null;
			
			try{
				conn = DBManager.getConnection();
				String sql = "update board set bsubject=?, bcontent=? ";
				
				if(notice != null && (notice.equals("N") || notice.equals("Y"))){
					sql += ",bnotice='"+notice+"' ";
				}
				
				sql += " where bidx=?";
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
				response.sendRedirect(request.getContextPath()+"/management/manageBoardView.jsp?bidx="+bidx+"&nowPage="+nowPage);
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				DBManager.close(psmt,conn);
			}
		}
	}
%>