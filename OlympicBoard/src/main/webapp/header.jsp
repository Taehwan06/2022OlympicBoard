<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="OlympicBoard.vo.*"%>
<%
	Member m = (Member)session.getAttribute("loginUser");
	String bidxH = request.getParameter("bidx");
%>
<header>
	<%if(m == null){%>
	<div>		
		<input type="button" name="login" value="로그인" onclick="location.href='<%=request.getContextPath() %>/login/login.jsp?bidx=<%=bidxH %>'">
		<input type="button" name="join" value="회원가입" onclick="location.href='<%=request.getContextPath() %>/login/join.jsp'">
	</div>
	<%}else if(m != null){ %>
	<div>
		<span><%=m.getMembername() %>님 환영합니다</span><br>
		<input type="button" name="logout" value="로그아웃" onclick="location.href='<%=request.getContextPath() %>/login/logout.jsp?bidx=<%=bidxH %>'">
		<input type="button" name="mypage" value="마이페이지" onclick="location.href='<%=request.getContextPath() %>/member/mypage.jsp'">
	</div>
	<%} %>
	<h2><a href="<%=request.getContextPath() %>">게시판</a></h2>
</header>