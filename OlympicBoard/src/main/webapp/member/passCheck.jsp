<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	String url = request.getParameter("url");

	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}else{		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>���� ������</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/passCheck.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/passCheck.js"></script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div>
			<div id="text">
				��й�ȣ�� �ٽ� �Է����ּ���.
			</div>
			<form name="passCheckFrm">
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
%>