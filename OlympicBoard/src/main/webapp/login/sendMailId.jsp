<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	String id = request.getParameter("id");
	
	MailSend.id(email,id);
	
	Check check = new Check();
	check.setSendId(true);
	session.setAttribute("check",check);
	
	response.sendRedirect("login.jsp");
%>