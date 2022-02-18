<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	String url = request.getParameter("url");
	String pass = "";
	boolean passCheck = false;
	
	ReUrl reurl = new ReUrl();
	String url = request.getContextPath();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
	Check check = (Check)session.getAttribute("check");
	if(check != null){
		passCheck = check.isPassCheck();
	}

	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}else{
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/passCheck.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/passCheck.js"></script>
<script>
	var url = "<%=url %>";
	<%	if(passCheck){
	%>		alert("비밀번호 오류!");
	<%	}
	%>
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div id="topButtonDiv">
			<img alt="화면 상단으로 이동하는 버튼입니다." src="<%=request.getContextPath() %>/upload/top.png"
			id="topButton" onclick="location.href='#top'">
		</div>
		<div>
			<div id="text">					
				비밀번호를 다시 입력해주세요.
			</div>
			<form name="passCheckFrm">
				<input type="hidden" name="url" value="<%=url %>">
				<div class="border">
					<label for="memberpassword"><span class="headSpan">비밀번호</span></label>
					<input type="password" name="memberpassword" id="memberpassword" 
					placeholder="비밀번호를 입력하세요">
				</div>
				<div class="button">
					<input type="button" value="확인" name="passCheck" onclick="passCheckFn()">
				</div>
			</form>
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	}
	session.setAttribute("check",null);
%>