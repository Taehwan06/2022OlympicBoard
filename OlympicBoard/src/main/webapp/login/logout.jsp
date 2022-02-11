<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");

	String bidx = request.getParameter("bidx");
	String nowPage = request.getParameter("nowPage");
	
	ListPageData listPageData = (ListPageData)session.getAttribute("listPageData");
	String searchValue = null;
	String searchType = null;
	if(listPageData != null){
		searchType = listPageData.getSearchType();
		searchValue = listPageData.getSearchValue();		
	}
	if(searchValue != null){
		try {
			searchValue = URLEncoder.encode(searchValue, "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	ReUrl reurl = (ReUrl)session.getAttribute("ReUrl");
	String url = reurl.getUrl()+"?bidx="+bidx+"&nowPage="+nowPage+"&searchType="+searchType+"&searchValue="+searchValue;	

	session.setAttribute("loginUser",null);

	response.sendRedirect(url);
%>