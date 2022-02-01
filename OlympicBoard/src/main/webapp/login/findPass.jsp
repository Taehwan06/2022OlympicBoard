<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="OlympicBoard.vo.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	Check check = (Check)session.getAttribute("check");
	boolean passCheck = false;
	if(check != null){
		passCheck = check.isPassCheck();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link href="<%=request.getContextPath() %>/css/loginHeader.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/findPass.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/findPass.js"></script>
<script>	
	<%	if(passCheck){			
	%>		alert("일치하는 회원이 없습니다.");
	<%	}
	%>	
</script>
</head>
<body>
	<%@ include file="/loginHeader.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div>
			<form name="findPassFrm">
				<div class="text">
					회원가입시 입력하신 이름, 아이디, 연락처, 이메일 주소를 입력해주세요.<br>
					임시 비밀번호를 이메일 주소로 보내드립니다.
				</div>
				<div>
					<div class="border">
						<label for="name"><span class="headSpan">이름</span></label>
						<input type="text" name="name" id="name" onblur="onBlurFn(this)"
						placeholder="회원 이름을 입력하세요">
					</div>
					<div>
						<label for="name"><span class="footSpan" id="nameSpan">이름을 입력하세요</span></label>
					</div>
				</div>
				<div>
					<div class="border">
						<label for="id"><span class="headSpan">아이디</span></label>
						<input type="text" name="id" id="id" onblur="onBlurFn(this)"
						placeholder="아이디를 입력하세요">
					</div>
					<div>
						<label for="id"><span class="footSpan" id="idSpan">아이디를 입력하세요</span></label>
					</div>
				</div>
				<div>
					<div class="border">
						<label for="phone1"><span class="headSpan">연락처</span></label>
						<input type="text" name="phone1" id="phone1" class="phone" onblur="onBlurFn(this)"
						placeholder="2~3자리"> -
						<input type="text" name="phone2" id="phone2" class="phone" onblur="onBlurFn(this)"
						placeholder="3~4자리"> -
						<input type="text" name="phone3" id="phone3" class="phone" onblur="onBlurFn(this)"
						placeholder="4자리">
					</div>
					<div>
						<label for="phone1"><span class="footSpan"  id="phoneSpan">연락처를 입력하세요</span></label>
					</div>
				</div>				
				<div>
					<div class="border">
						<label for="email"><span class="headSpan">이메일</span></label>
						<input type="text" name="email" id="email" onblur="onBlurFn(this)"
						placeholder="이메일 주소를 입력하세요">
					</div>
					<div>
						<label for="email"><span class="footSpan" id="emailSpan">이메일을 입력하세요</span></label>
					</div>
				</div>
				<div>
					<input type="button" name="findPassSubmit" value="비밀번호 찾기" onclick="findPassFn()">
				</div>
			</form>
			<div id="last">
				<input type="button" name="login" value="로그인" onclick="loginFn()">
				<input type="button" name="join" value="회원가입" onclick="joinFn()">
				<input type="button" name="findId" value="아이디 찾기" onclick="findIdFn()">
			</div>		
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	session.setAttribute("check",null);
%>