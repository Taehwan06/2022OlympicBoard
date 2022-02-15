<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
String bimgsys = null;
String bimgori = null;
String bimgsys2 = null;
String bimgori2 = null;
String bimgsys3 = null;
String bimgori3 = null;

Member loginUser = (Member)session.getAttribute("loginUser");

Board board = new Board();

board.setBimgori("1234");
session.setAttribute("board",board);

board = (Board)session.getAttribute("board");
if(board != null){
	bimgsys = board.getBimgsys();
	bimgori = board.getBimgori();
	bimgsys2 = board.getBimgsys2();
	bimgori2 = board.getBimgori2();
	bimgsys3 = board.getBimgsys3();
	bimgori3 = board.getBimgori3();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		margin: auto;
		background-image: url("<%=request.getContextPath() %>/upload/back3.png");
	    background-repeat : no-repeat;
	    background-size : contain;
	    background-position: center bottom;
	}
</style>
</head>
<body>
	bimgsys = <%=bimgsys %>;
	bimgori = <%=bimgori %>;
	bimgsys2 = <%=bimgsys2 %>;
	bimgori2 = <%=bimgori2 %>;
	bimgsys3 = <%=bimgsys3 %>;
	bimgori3 = <%=bimgori3 %>;
	<img src="<%=request.getContextPath() %>/upload/back.png">
</body>
</html>