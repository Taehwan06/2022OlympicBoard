<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String result = request.getParameter("result");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="<%=request.getContextPath() %>/css/findId.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/findId.js"></script>
<script>
	console.log(<%= result %>);
	<%	if(result != null){
	%>		alert("일치하는 회원이 없습니다.");
	<%	}	
		result = null;
	%>
	console.log(<%= result %>);
</script>
</head>
<body>
	<%@ include file="/loginHeader.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div>
			<form name="findIdFrm">
				<div class="text">
					회원가입시 입력하신 이름과 연락처를 입력해주세요.
				</div>
				<div>
					<div class="border">
						<label for="name"><span class="headSpan">이름</span></label>
						<input type="text" name="name" id="name" placeholder="회원 이름을 입력하세요">
					</div>
					<div>
					<label for="name"><span class="footSpan" id="nameSpan">이름을 입력하세요</span></label>
					</div>
				</div>
				<div>
					<div class="border">
						<label for="phone1"><span class="headSpan">연락처</span></label>
						<input type="text" name="phone1" id="phone1" class="phone" placeholder="2~3자리"> -
						<input type="text" name="phone2" id="phone2" class="phone" placeholder="3~4자리"> -
						<input type="text" name="phone3" id="phone3" class="phone" placeholder="4자리">
					</div>
					<div>
					<label for="phone1"><span class="footSpan"  id="phoneSpan">연락처를 입력하세요</span></label>
					</div>
				</div>
				<div>
					<input type="button" name="findIdSubmit" value="아이디 찾기" onclick="findIdFn()">
				</div>				
			</form>
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