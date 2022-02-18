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
<title>ȸ�� ���� ��ȸ</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/memberView.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/mypage.js"></script>
<script>
	<%	if(check != null && check.getWithdraw() != null && check.getWithdraw().equals("success")){
	%>		alert("<%=member.getMemberid() %>���� ȸ�� ���� Ż�� �Ϸ�Ǿ����ϴ�.");
	<%	}else if(check != null && check.getWithdraw() != null && check.getWithdraw().equals("fail")){
	%>		alert("<%=member.getMemberid() %>���� ȸ�� ���� Ż�� �����߽��ϴ�.");
	<%	}
		if(check != null && check.getRestore() != null && check.getRestore().equals("success")){
	%>		alert("<%=member.getMemberid() %>���� ȸ�� ���� ������ �Ϸ�Ǿ����ϴ�.");
	<%	}else if(check != null && check.getRestore() != null && check.getRestore().equals("fail")){
	%>		alert("<%=member.getMemberid() %>���� ȸ�� ���� ������ �����߽��ϴ�.");
	<%	}
		if(check != null && check.getMemberModify() != null && check.getMemberModify().equals("success")){
	%>		alert("<%=member.getMemberid() %>���� ȸ�� ������ �����Ǿ����ϴ�.");
	<%	}else if(check != null && check.getMemberModify() != null && check.getMemberModify().equals("fail")){
	%>		alert("<%=member.getMemberid() %>���� ȸ�� ���� ������ �����߽��ϴ�.");
	<%	}
	%>
	
	function managementFn(){
		location.href="management.jsp?searchType=<%=searchType %>&searchValue=<%=searchValue %>&nowPage=<%=nowPage %>";
	}
	
	function modifyManagementFn(){
		location.href="manageModify.jsp?midx=<%=midx %>";
	}
	
	function withdrawManagementFn(){
		var result = confirm("<%=member.getMemberid() %> ���� ���� Ż�� ó���Ͻðڽ��ϱ�?");
		if(result){
			location.href="manageWithdraw.jsp?midx=<%=midx %>";
		}
	}
	function restoreFn(){
		var result = confirm("<%=member.getMemberid() %> ���� ȸ�������� �����Ͻðڽ��ϱ�?");
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
			<img alt="ȭ�� ������� �̵��ϴ� ��ư�Դϴ�." src="<%=request.getContextPath() %>/upload/top.png"
			id="topButton" onclick="location.href='#top'">
		</div>
		<div>		
			<div>
				<div class="border">
					<span class="left">ȸ�� ��ȣ</span>
					<span class="right"><%=member.getMidx() %></span>
				</div>
				<div class="border">
					<span class="left">���̵�</span>
					<span class="right"><%=member.getMemberid() %></span>
				</div>
				<div class="border">
					<span class="left">����</span>
					<span class="right"><%=member.getMembername() %></span>
				</div>
				<div class="border">
					<span class="left">�������</span>
					<span class="right"><%=member.getBirth() %></span>
				</div>
				<div class="border">
					<span class="left">����ó</span>
					<span class="right"><%=member.getPhone() %></span>
				</div>
				<div class="border">
					<span class="left">�̸��� �ּ�</span>
					<span class="right"><%=member.getEmail() %></span>
				</div>
				<div class="border">
					<span class="left">�ۼ��� �Խñ� ��</span>
					<span class="right"><%=cnt %></span>
				</div>
				<div class="border">
					<span class="left">������</span>
					<span class="right"><%=member.getEnterdate() %></span>
				</div>
				<div class="border">
					<span class="left">ȸ�� ���</span>
					<span class="right"><%=member.getGrade() %></span>
				</div>
				<div class="border">
					<span class="left">Ż�� ����</span>
					<span class="right"><%=member.getDelyn() %></span>
				</div>
				<div class="border">
			<%	if(member.getDelyn().equals("Y") || member.getOriginBreakdate() == null){
			%>		<span class="left">Ż����</span>
			<%	}else{
			%>		<span class="left">������</span>
			<%	}
			%>		<span class="right"><%=member.getBreakdate() %></span>
				</div>
			</div>
			<div class="button">
				<div class="border" onclick="managementFn()">
					<span>���</span>
				</div>
			<%	if(member.getDelyn().equals("N")){
			%>
				<div class="border" onclick="modifyManagementFn()">
					<span>ȸ������ ����</span>
				</div>
			<%	}
				if(member.getDelyn().equals("Y")){
			%>
				<div class="border" onclick="restoreFn()">
					<span>ȸ�� ����</span>
				</div>
			<%	}
				if(member.getDelyn().equals("N")){
			%>
				<div class="border" onclick="withdrawManagementFn()">
					<span>ȸ�� Ż��</span>
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