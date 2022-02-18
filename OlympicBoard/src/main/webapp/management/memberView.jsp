<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String midx = request.getParameter("midx");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	String nowPage = request.getParameter("nowPage");
	
	ReUrl reurl = new ReUrl();
	String url = request.getContextPath();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
	ListPageData listPageData = (ListPageData)session.getAttribute("listPageData");
	if(listPageData != null){
		searchType = listPageData.getSearchType();
		searchValue = listPageData.getSearchValue();
		nowPage = listPageData.getNowPage();
	}
		
	int cnt = 0;
	String memberModify = "";
	String withdraw = "";
	
	Check check = (Check)session.getAttribute("check");
	
	Member member = new Member();
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null || !loginUser.getGrade().equals("A")){
		response.sendRedirect(request.getContextPath());
	}else{		
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = DBManager.getConnection();
			
			String sql = "select * from (select count(*) c from board where midx=?)";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,midx);
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				cnt = rs.getInt("c");
			}
			
			sql = "select * from member where midx=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,midx);
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				member.setBirth(rs.getString("birth"));
				member.setEmail(rs.getString("email"));
				member.setEnterdate(rs.getString("enterdate"));
				member.setGrade(rs.getString("grade"));
				member.setMemberid(rs.getString("memberid"));
				member.setMembername(rs.getString("membername"));
				member.setMidx(rs.getInt("midx"));
				member.setOriginEnterdate(rs.getString("enterdate"));
				member.setPhone(rs.getString("phone"));
				member.setBreakdate(rs.getString("breakdate"));
				member.setDelyn(rs.getString("delyn"));
				member.setOriginBreakdate(rs.getString("breakdate"));
				
				session.setAttribute("member",member);
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
<title>회원 정보 조회</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/memberView.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/mypage.js"></script>
<script>
	<%	if(check != null && check.getWithdraw() != null && check.getWithdraw().equals("success")){
	%>		alert("<%=member.getMemberid() %>님의 회원 강제 탈퇴가 완료되었습니다.");
	<%	}else if(check != null && check.getWithdraw() != null && check.getWithdraw().equals("fail")){
	%>		alert("<%=member.getMemberid() %>님의 회원 강제 탈퇴가 실패했습니다.");
	<%	}
		if(check != null && check.getRestore() != null && check.getRestore().equals("success")){
	%>		alert("<%=member.getMemberid() %>님의 회원 정보 복구가 완료되었습니다.");
	<%	}else if(check != null && check.getRestore() != null && check.getRestore().equals("fail")){
	%>		alert("<%=member.getMemberid() %>님의 회원 정보 복구가 실패했습니다.");
	<%	}
		if(check != null && check.getMemberModify() != null && check.getMemberModify().equals("success")){
	%>		alert("<%=member.getMemberid() %>님의 회원 정보가 수정되었습니다.");
	<%	}else if(check != null && check.getMemberModify() != null && check.getMemberModify().equals("fail")){
	%>		alert("<%=member.getMemberid() %>님의 회원 정보 수정이 실패했습니다.");
	<%	}
	%>
	
	function managementFn(){
		location.href="management.jsp?searchType=<%=searchType %>&searchValue=<%=searchValue %>&nowPage=<%=nowPage %>";
	}
	
	function modifyManagementFn(){
		location.href="manageModify.jsp?midx=<%=midx %>";
	}
	
	function withdrawManagementFn(){
		var result = confirm("<%=member.getMemberid() %> 님을 강제 탈퇴 처리하시겠습니까?");
		if(result){
			location.href="manageWithdraw.jsp?midx=<%=midx %>";
		}
	}
	function restoreFn(){
		var result = confirm("<%=member.getMemberid() %> 님의 회원정보를 복구하시겠습니까?");
		if(result){
			location.href = "restoreMember.jsp?midx=<%=midx %>";
		}
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
			<div>
				<div class="border">
					<span class="left">회원 번호</span>
					<span class="right"><%=member.getMidx() %></span>
				</div>
				<div class="border">
					<span class="left">아이디</span>
					<span class="right"><%=member.getMemberid() %></span>
				</div>
				<div class="border">
					<span class="left">성명</span>
					<span class="right"><%=member.getMembername() %></span>
				</div>
				<div class="border">
					<span class="left">생년월일</span>
					<span class="right"><%=member.getBirth() %></span>
				</div>
				<div class="border">
					<span class="left">연락처</span>
					<span class="right"><%=member.getPhone() %></span>
				</div>
				<div class="border">
					<span class="left">이메일 주소</span>
					<span class="right"><%=member.getEmail() %></span>
				</div>
				<div class="border">
					<span class="left">작성한 게시글 수</span>
					<span class="right"><%=cnt %></span>
				</div>
				<div class="border">
					<span class="left">가입일</span>
					<span class="right"><%=member.getEnterdate() %></span>
				</div>
				<div class="border">
					<span class="left">회원 등급</span>
					<span class="right"><%=member.getGrade() %></span>
				</div>
				<div class="border">
					<span class="left">탈퇴 여부</span>
					<span class="right"><%=member.getDelyn() %></span>
				</div>
				<div class="border">
			<%	if(member.getDelyn().equals("Y") || member.getOriginBreakdate() == null){
			%>		<span class="left">탈퇴일</span>
			<%	}else{
			%>		<span class="left">복구일</span>
			<%	}
			%>		<span class="right"><%=member.getBreakdate() %></span>
				</div>
			</div>
			<div class="button">
				<div class="border" onclick="managementFn()">
					<span>목록</span>
				</div>
			<%	if(member.getDelyn().equals("N")){
			%>
				<div class="border" onclick="modifyManagementFn()">
					<span>회원정보 수정</span>
				</div>
			<%	}
				if(member.getDelyn().equals("Y")){
			%>
				<div class="border" onclick="restoreFn()">
					<span>회원 복구</span>
				</div>
			<%	}
				if(member.getDelyn().equals("N")){
			%>
				<div class="border" onclick="withdrawManagementFn()">
					<span>회원 탈퇴</span>
				</div>
			<%	}
			%>
			</div>
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	}
	session.setAttribute("check",null);
%>