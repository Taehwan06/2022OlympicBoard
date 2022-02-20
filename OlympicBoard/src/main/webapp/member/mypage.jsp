<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	int cnt = 0;
	String memberModify = "";
	String withdraw = "";
	
	String email = "";
	String phone = "";
	
	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);

	Check check = (Check)session.getAttribute("check");
	if(check != null){
		memberModify = check.getMemberModify();
		withdraw = check.getWithdraw();
	}
	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}else{
		int midx = loginUser.getMidx();

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = DBManager.getConnection();
			
			String sql = "select * from (select count(*) c from board where midx=?)";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,midx);
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				cnt = rs.getInt("c");
			}
						
			conn = DBManager.getConnection();
			
			sql = "select * from member where midx=?";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,midx);
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				email = rs.getString("email");
				phone = rs.getString("phone");		
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
<title>���� ������</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/mypage.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/mypage.js"></script>
<script>
	<%	if(memberModify == null){
	%>
	<%	}else if(memberModify.equals("success")){
	%>		alert("ȸ������ ������ �Ϸ�Ǿ����ϴ�.");
	<%	}else if(memberModify.equals("fail")){
	%>		alert("ȸ������ ������ �����߽��ϴ�.");
	<%	}
		if(withdraw == null){
	%>		
	<%	}else if(withdraw.equals("fail")){
	%>		alert("ȸ�� Ż�� �����߽��ϴ�.");
	<%	}
	%>
	
	function mylistFn(){
		location.href="mylist.jsp?midx=<%=loginUser.getMidx() %>";
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
					<span class="left">���̵�</span>
					<span class="right"><%=loginUser.getMemberid() %></span>
				</div>
				<div class="border">
					<span class="left">����</span>
					<span class="right"><%=loginUser.getMembername() %></span>
				</div>
				<div class="border">
					<span class="left">����ó</span>
					<span class="right"><%=phone %></span>
				</div>
				<div class="border">
					<span class="left">�̸��� �ּ�</span>
					<span class="right"><%=email %></span>
				</div>
				<div class="border">
					<span class="left">������</span>
					<span class="right"><%=loginUser.getEnterdate() %></span>
				</div>
				<div class="border">
					<span class="left">�ۼ��� �Խñ� ��</span>
					<span class="right"><%=cnt %></span>
				</div>
			</div>
			<div class="button">
				<div class="border" onclick="mylistFn()">
					<span>���� �ۼ��� �� ��������</span>
				</div><br>
				<div class="border" onclick="modifyFn()">
					<span>ȸ������ ����</span>
				</div><br>
				<div class="border" onclick="withdrawFn()">
					<span>ȸ�� Ż��</span>
				</div>
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