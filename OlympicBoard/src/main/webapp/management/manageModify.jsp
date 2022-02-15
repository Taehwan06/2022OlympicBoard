<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String phone = "";
	String phone1 = "";
	String phone2 = "";
	String phone3 = "";
	String birth1 = "";
	String birth2 = "";
	String birth3 = "";
	String midx = request.getParameter("midx");
	
	Member member = new Member();

	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}else{
		if(!loginUser.getGrade().equals("A")){
			response.sendRedirect(request.getContextPath());
		}else{
		
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			try{
				conn = DBManager.getConnection();
				
				String sql = "select * from member where midx=?";
				psmt = conn.prepareStatement(sql);
				psmt.setString(1,midx);
				
				rs = psmt.executeQuery();
				
				if(rs.next()){
					phone = rs.getString("phone");
					String[] phoneA = phone.split("-");
					phone1 = phoneA[0];
					phone2 = phoneA[1];
					phone3 = phoneA[2];
					
					String birth = rs.getString("birth");
					String[] birthA = birth.split("년");
					birth1 = birthA[0];
					String[] birthA2 = birthA[1].split("월");
					birth2 = birthA2[0];
					String[] birthA3 = birthA2[1].split("일");
					birth3 = birthA3[0];
					
					member.setEmail(rs.getString("email"));
					member.setGrade(rs.getString("grade"));
					member.setMembername(rs.getString("membername"));
					member.setMemberid(rs.getString("memberid"));
					member.setMidx(rs.getInt("midx"));
					member.setEnterdate(rs.getString("enterdate"));
					member.setDelyn(rs.getString("delyn"));
					member.setBreakdate(rs.getString("breakdate"));
					member.setOriginBreakdate(rs.getString("breakdate"));
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
<link href="<%=request.getContextPath() %>/css/manageModify.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	function modifySubmitFn(){
		var result = confirm("<%=member.getMemberid() %> 님의 회원정보를 수정하시겠습니까?");
		if(result){
			document.modifyFrm.method = "post";
			document.modifyFrm.action = "manageModifyOk.jsp";
			document.modifyFrm.submit();
		}
	}
	
	function cancelFn(){
		location.href="memberView.jsp?midx=<%=midx %>";
	}
	
	function onblurFn(obj){
		$(obj).css("color", "black");
	}
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
			<form name="modifyFrm">
				<input type="hidden" name="midx" value="<%=midx %>">
				<div class="border">
					<span class="headSpan">회원 번호</span>
					<input type="text" name="midx" id="midx" 
					value="<%=member.getMidx() %>" readonly>
				</div>
				<div class="border">
					<span class="headSpan">아이디</span>
					<input type="text" name="id" id="id" 
					value="<%=member.getMemberid() %>" readonly>
				</div>
				<div class="border">
					<label for="name"><span class="headSpan">성명</span></label>
					<input type="text" name="name" id="name" 
					value="<%=member.getMembername() %>" onblur="onblurFn(this)">
				</div>
				<div class="border">
					<label for="email"><span class="headSpan">이메일</span></label>
					<input type="text" name="email" id="email" 
					value="<%=member.getEmail() %>" onblur="onblurFn(this)">
				</div>
				<div class="border">
					<label for="phone1"><span class="headSpan">연락처</span></label>
					<input type="text" name="phone1" id="phone1" class="phone" 
					value="<%=phone1 %>" onblur="onblurFn(this)"> -
					<input type="text" name="phone2" id="phone2" class="phone" 
					value="<%=phone2 %>" onblur="onblurFn(this)"> -
					<input type="text" name="phone3" id="phone3" class="phone" 
					value="<%=phone3 %>" onblur="onblurFn(this)">
				</div>
				<div class="border" id="birth">
					<label for="birth1"><span class="headSpan">생년월일</span></label>
					<input type="text" name="birth1" id="birth1" class="birth" 
					value="<%=birth1 %>" onblur="onblurFn(this)">년
					<input type="text" name="birth2" id="birth2" class="birth" 
					value="<%=birth2 %>" onblur="onblurFn(this)">월
					<input type="text" name="birth3" id="birth3" class="birth" 
					value="<%=birth3 %>" onblur="onblurFn(this)">일
				</div>
				<div class="border" id="birth">
					<label for="grade"><span class="headSpan">회원 등급</span></label>
					<label for="grade"><div id="gradeDiv">
						<select id="grade" name="grade">
							<option name="grade" value="G" 
							<% if(member.getGrade()!=null && member.getGrade().equals("G")){ out.print("selected"); } %>>일반 회원</option>
							<option name="grade" value="A" 
							<% if(member.getGrade()!=null && member.getGrade().equals("A")){ out.print("selected"); } %>>관리자</option>
						</select>
					</div></label>
				</div>
				<div class="border">
					<span class="headSpan">가입일</span>
					<input type="text" name="enterdate" id="enterdate" 
					value="<%=member.getEnterdate() %>" readonly>
				</div>
				<div class="border">
					<span class="headSpan">탈퇴 여부</span>
					<input type="text" name="delyn" id="delyn" 
					value="<%=member.getDelyn() %>" readonly>
				</div>
				<div class="border">
			<%	if(member.getDelyn().equals("Y") || member.getOriginBreakdate() == null){
			%>		<span class="headSpan">탈퇴일</span>
			<%	}else{
			%>		<span class="headSpan">복구일</span>
			<%	}
			%>		<input type="text" name="breakdate" id="breakdate" 
					value="<%=member.getBreakdate() %>" readonly>
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
	}
%>