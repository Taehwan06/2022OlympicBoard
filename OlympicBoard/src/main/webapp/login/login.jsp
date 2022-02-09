<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="OlympicBoard.vo.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String memberid = request.getParameter("memberid");
	String bidx = request.getParameter("bidx");
	String nowPage = request.getParameter("nowPage");
		
	Check check = (Check)session.getAttribute("check");
	String joinCheck = null;
	String loginCheck = null;
	boolean sendId = false;
	if(check != null){
		joinCheck = check.getJoinCheck();
		loginCheck = check.getLoginCheck();
		sendId = check.isSendId();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="<%=request.getContextPath() %>/css/loginHeader.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/login.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/login.js"></script>
<script>
	var nowPage = "<%=nowPage %>";
	<%	if(joinCheck == null){
	%>		
	<%	}else if(joinCheck.equals("success")){
	%>		alert("회원가입이 완료되었습니다.");
	<%	}else if(joinCheck.equals("fail")){
	%>		alert("회원가입에 실패했습니다.");
	<%	}
	%>
	<%	if(loginCheck == null){
	%>		
	<%	}else if(loginCheck.equals("pass")){
	%>		alert("비밀번호 오류!");
	<%	}else if(loginCheck.equals("all")){
	%>		alert("등록된 사용자가 없습니다!");
	<%	}
	%>
	<%	if(sendId){
	%>		alert("아이디를 회원님의 이메일로 발송했습니다.");
	<%	}
	%>
</script>
</head>
<body>
	<%@ include file="/loginHeader.jsp" %>
	<%@ include file="/nav.jsp" %>	
	<section>
		<div>
			<form name="loginFrm">
				<div>
					<div class="border">
						<input type="hidden" name="bidx" value="<%=bidx %>">
						<label for="memberid"><span class="headSpan">아이디</span></label>
						<input type="text" name="memberid" id="memberid" onblur="onBlurFn(this)"
						<%if(memberid != null && !memberid.equals("") && !memberid.equals("null")) out.print("value='"+memberid+"'"); %>>
					</div>
					<div>
						<label for="memberid"><span class="footSpan">아이디를 입력하세요</span></label>
					</div>
				</div>
				<div>
					<div class="border">
						<label for="memberpassword"><span class="headSpan">비밀번호</span></label>
						<input type="password" name="memberpassword" id="memberpassword" onblur="onBlurFn(this)">
					</div>
					<div>
						<label for="memberpassword"><span class="footSpan">비밀번호를 입력하세요</span></label>
					</div>
				</div>
			</form>
			<div>
				<input type="button" name="login" value="로그인" onclick="loginFn()">
			</div>			
			<div id="last">
				<input type="button" name="findId" value="아이디 찾기" onclick="findIdFn()">
				<input type="button" name="findPass" value="비밀번호 찾기" onclick="findPassFn()">
				<input type="button" name="join" value="회원가입" onclick="joinFn()">
			</div>
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	session.setAttribute("check",null);
%>