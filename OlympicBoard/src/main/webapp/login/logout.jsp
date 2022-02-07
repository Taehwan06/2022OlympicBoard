<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="OlympicBoard.vo.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bidx = request.getParameter("bidx");

	ReUrl reurl = (ReUrl)session.getAttribute("ReUrl");
	String url = reurl.getUrl()+"?bidx="+bidx;

	session.setAttribute("loginUser",null);

	response.sendRedirect(url);
%>