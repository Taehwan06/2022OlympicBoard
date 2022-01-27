<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	Member login = (Member)session.getAttribute("loginUser");
	
	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);		
%>