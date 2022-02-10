<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	Check check = (Check)session.getAttribute("check");
	boolean idConfirm = false;
	if(check != null){
		idConfirm = check.isIdConfirm();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="<%=request.getContextPath() %>/css/loginHeader.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/join.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/js/join.js"></script>
<script>
	<%	if(idConfirm){
	%>		alert("이미 존재하는 아이디 입니다. 다시 확인해주세요.");
	<%	}
	%>
</script>
</head>
<body>
	<%@ include file="/loginHeader.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div>
			<form name="joinFrm">
				<div>
					<div class="border">
						<label for="id"><span class="headSpan">아이디</span></label>
						<input type="text" name="id" id="id" onblur="onBlurFn(this)"
						placeholder="영문시작 6~20자리의 영문or숫자">
					</div>
					<div>
						<label for="id"><span class="footSpan" id="idSpan">아이디를 입력하세요</span></label>
					</div>
				</div>
				<div>
					<div class="border">
						<label for="pass"><span class="headSpan">비밀번호</span></label>
						<input type="password" name="pass" id="pass" onblur="onBlurFn(this)"
						placeholder="영문, 숫자, 특수문자 모두 포함 6~20자리">
					</div>
					<div>
						<label for="pass"><span class="footSpan" id="passSpan">비밀번호를 입력하세요</span></label>
					</div>
				</div>
				<div>
					<div class="border">
						<label for="passcheck"><span class="headSpan">비밀번호 확인</span></label>
						<input type="password" name="passcheck" id="passcheck" onblur="onBlurFn(this)"
						placeholder="비밀번호를 다시 입력하세요">
					</div>
					<div>
						<label for="passcheck"><span class="footSpan" id="passcheckSpan">비밀번호를 다시 입력하세요</span></label>
					</div>
				</div>
				<div>
					<div class="border">
						<label for="name"><span class="headSpan">이름</span></label>
						<input type="text" name="name" id="name" onblur="onBlurFn(this)"
						placeholder="한글로 입력하세요">
					</div>
					<div>
						<label for="name"><span class="footSpan" id="nameSpan">이름을 입력하세요</span></label>
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
					<div class="border" id="birth">
						<label for="birth1"><span class="headSpan">생년월일</span></label>
						<input type="text" name="birth1" id="birth1" class="birth" onblur="onBlurFn(this)"
						placeholder="4자리">년
						<input type="text" name="birth2" id="birth2" class="birth" onblur="onBlurFn(this)"
						placeholder="1~2자리">월
						<input type="text" name="birth3" id="birth3" class="birth" onblur="onBlurFn(this)"
						placeholder="1~2자리">일
					</div>
					<div>
						<label for="birth1"><span class="footSpan" id="birthSpan">생년월일을 입력하세요</span></label>
					</div>
				</div>
			</form>
			<div id="submitDiv">
				<input type="button" name="joinSubmit" value="회원가입" onclick="joinSubmitFn()">
			</div>
			<div id="last">
				<input type="button" name="login" value="로그인" onclick="loginFn()">
				<input type="button" name="join" value="아이디 찾기" onclick="findIdFn()">
				<input type="button" name="findPass" value="비밀번호 찾기" onclick="findPassFn()">
			</div>
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	session.setAttribute("check",null);
%>