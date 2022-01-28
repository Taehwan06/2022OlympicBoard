<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="<%=request.getContextPath() %>/css/findIdSuccess.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/findId.js"></script>
<script>		
</script>
</head>
<body>
	<%@ include file="/loginHeader.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div>			
			<div class="text">
				회원님의 아이디는 <span id="id"><%=id %></span> 입니다.
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