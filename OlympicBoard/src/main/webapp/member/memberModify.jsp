<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
	String email = "";
	String phone = "";
	String phone1 = "";
	String phone2 = "";
	String phone3 = "";
	String birth1 = "";
	String birth2 = "";
	String birth3 = "";

	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}else{		
		String birth = loginUser.getBirth();
		String[] birthA = birth.split("년");
		birth1 = birthA[0];
		String[] birthA2 = birthA[1].split("월");
		birth2 = birthA2[0];
		String[] birthA3 = birthA2[1].split("일");
		birth3 = birthA3[0];
		
		int midx = loginUser.getMidx();

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = DBManager.getConnection();
			
			String sql = "select * from member where midx=?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,midx);
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				email = rs.getString("email");
				phone = rs.getString("phone");
				String[] phoneA = phone.split("-");
				phone1 = phoneA[0];
				phone2 = phoneA[1];
				phone3 = phoneA[2];
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(psmt,conn,rs);
		}
		
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/memberModify.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/js/memberModify.js"></script>
<script>
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div>
			<form name="modifyFrm">
				<div>
					<div class="border">
						<label for="id"><span class="headSpan">아이디</span></label>
						<input type="text" name="id" id="id" 
						value="<%=loginUser.getMemberid() %>" readonly>
					</div>
					<div>
						<label for="id"><span class="footSpan" id="idSpan"></span></label>
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
						<input type="text" name="name" id="name" 
						value="<%=loginUser.getMembername() %>" readonly>
					</div>
					<div>
						<label for="name"><span class="footSpan" id="nameSpan"></span></label>
					</div>
				</div>
				<div>
					<div class="border">
						<label for="email"><span class="headSpan">이메일</span></label>
						<input type="text" name="email" id="email" onblur="onBlurFn(this)"
						value="<%=email %>" placeholder="이메일 주소를 입력하세요">
					</div>
					<div>
						<label for="email"><span class="footSpan" id="emailSpan">이메일을 입력하세요</span></label>
					</div>
				</div>
				<div>
					<div class="border">
						<label for="phone1"><span class="headSpan">연락처</span></label>
						<input type="text" name="phone1" id="phone1" class="phone" onblur="onBlurFn(this)"
						value="<%=phone1 %>" placeholder="2~3자리"> -
						<input type="text" name="phone2" id="phone2" class="phone" onblur="onBlurFn(this)"
						value="<%=phone2 %>" placeholder="3~4자리"> -
						<input type="text" name="phone3" id="phone3" class="phone" onblur="onBlurFn(this)"
						value="<%=phone3 %>" placeholder="4자리">
					</div>
					<div>
						<label for="phone1"><span class="footSpan"  id="phoneSpan">연락처를 입력하세요</span></label>
					</div>
				</div>
				<div>
					<div class="border" id="birth">
						<label for="birth1"><span class="headSpan">생년월일</span></label>
						<input type="text" name="birth1" id="birth1" class="birth" 
						value="<%=birth1 %>" readonly>년
						<input type="text" name="birth2" id="birth2" class="birth" 
						value="<%=birth2 %>" readonly>월
						<input type="text" name="birth3" id="birth3" class="birth" 
						value="<%=birth3 %>" readonly>일
					</div>
					<div>
						<label for="birth1"><span class="footSpan" id="birthSpan">생년월일을 입력하세요</span></label>
					</div>
				</div>
			</form>
			<div id="submitDiv">
				<input type="button" name="modifySubmit" value="저장" onclick="modifySubmitFn()">
				<input type="button" name="modifycancel" value="취소" onclick="cancelFn()">
			</div>	
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	}
%>