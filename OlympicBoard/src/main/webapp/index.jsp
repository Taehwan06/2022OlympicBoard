<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);

	String withdraw = "";

	Check check = (Check)session.getAttribute("check");
	if(check != null){		
		withdraw = check.getWithdraw();
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2022 베이징 올림픽</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/index.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<style>

</style>
<script>
	<%	if(withdraw == null){
	%>	
	<%	}else if(withdraw.equals("success")){
	%>		alert("회원 탈퇴가 완료되었습니다.");
	<%	}
	%>
</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<%@ include file="nav.jsp" %>
	<section>
		<div id="topButtonDiv">
			<img alt="화면 상단으로 이동하는 버튼입니다." src="<%=request.getContextPath() %>/upload/top.png"
			id="topButton" onclick="location.href='#top'">
		</div>
		<div>
			메인 화면						
		</div>
	</section>
	<%@ include file="footer.jsp" %>
</body>
</html>
<%
	session.setAttribute("check",null);
%>