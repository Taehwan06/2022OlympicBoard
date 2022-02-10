<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	String idAll = request.getParameter("id");
	String idSub = idAll.substring(3);
	String id = "***"+idSub;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 완료</title>
<link href="<%=request.getContextPath() %>/css/loginHeader.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/findIdSuccess.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/findIdSuccess.js"></script>
<script>
	var idAll = "<%=idAll%>";
	var email = "<%=email%>";
</script>
</head>
<body>
	<%@ include file="/loginHeader.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div>			
			<div id="mainText">
				회원님의 아이디는 <span id="id"><%=id %></span> 입니다.
			</div>
			<div>
				<input type="button" name="sendMailId" value="전체 아이디 메일로 받기" onclick="sendMailIdFn()">
				<div id="sendText">전체 아이디를 회원 가입시 입력하신 메일주소로 보내드립니다.</div>
			</div>
			<div id="last">
				<input type="button" name="login" value="로그인" onclick="loginFn()">
				<input type="button" name="join" value="회원가입" onclick="joinFn()">
				<input type="button" name="findPass" value="비밀번호 찾기" onclick="findPassFn()">
			</div>		
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>