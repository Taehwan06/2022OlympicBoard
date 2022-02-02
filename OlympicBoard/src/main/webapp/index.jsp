<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="OlympicBoard.vo.*" %>
<%@ include file="/scriptlet/base.jsp"%>
<%
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