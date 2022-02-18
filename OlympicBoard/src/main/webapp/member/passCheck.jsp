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
<title>��й�ȣ Ȯ��</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/passCheck.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/passCheck.js"></script>
<script>
	var url = "<%=url %>";
	<%	if(passCheck){
	%>		alert("��й�ȣ ����!");
	<%	}
	%>
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div id="topButtonDiv">
			<img alt="ȭ�� ������� �̵��ϴ� ��ư�Դϴ�." src="<%=request.getContextPath() %>/upload/top.png"
			id="topButton" onclick="location.href='#top'">
		</div>
		<div>
			<div id="text">					
				��й�ȣ�� �ٽ� �Է����ּ���.
			</div>
			<form name="passCheckFrm">
				<input type="hidden" name="url" value="<%=url %>">
				<div class="border">
					<label for="memberpassword"><span class="headSpan">��й�ȣ</span></label>
					<input type="password" name="memberpassword" id="memberpassword" 
					placeholder="��й�ȣ�� �Է��ϼ���">
				</div>
				<div class="button">
					<input type="button" value="Ȯ��" name="passCheck" onclick="passCheckFn()">
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