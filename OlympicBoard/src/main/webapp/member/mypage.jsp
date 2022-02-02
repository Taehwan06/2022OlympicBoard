<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	int cnt = 0;

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
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/js/mypage.js"></script>
</head>
<body>
	<%@ include file="/loginHeader.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
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
					<span class="right"><%=loginUser.getPhone() %></span>
				</div>
				<div class="border">
					<span class="left">�̸��� �ּ�</span>
					<span class="right"><%=loginUser.getEmail() %></span>
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
					<span>���� �� �� ��������</span>
				</div><br>
				<div class="border" onclick="modifyFn()()">
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