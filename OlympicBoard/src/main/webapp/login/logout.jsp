<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="OlympicBoard.vo.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String bidx = request.getParameter("bidx");
	String nowPage = request.getParameter("nowPage");

	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");

	ReUrl reurl = (ReUrl)session.getAttribute("ReUrl");
	String url = reurl.getUrl()+"?bidx="+bidx+"&nowPage="+nowPage+"&searchType="+searchType+"&searchValue="+searchValue;	

	session.setAttribute("loginUser",null);

	response.sendRedirect(url);
%>