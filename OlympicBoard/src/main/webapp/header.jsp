<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="OlympicBoard.vo.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	Member m = (Member)session.getAttribute("loginUser");
	String bidxH = request.getParameter("bidx");
	String nowPageH = request.getParameter("nowPage");
	
	String searchTypeH = request.getParameter("searchType");
	String searchValueH = request.getParameter("searchValue");
%>
<header>
	<%	if(m == null){
	%>		<div>		
				<input type="button" name="login" value="로그인" 
				onclick="location.href='<%=request.getContextPath() %>/login/login.jsp?bidx=<%=bidxH %>&nowPage=<%=nowPageH %>&searchType=<%=searchTypeH%>&searchValue=<%=searchValueH%>'">
				<input type="button" name="join" value="회원가입" 
				onclick="location.href='<%=request.getContextPath() %>/login/join.jsp'">
			</div>
	<%	}else if(m != null && m.getGrade().equals("G")){ 
	%>		<div>
				<span><%=m.getMembername() %>님 환영합니다</span><br>
				<input type="button" name="logout" value="로그아웃" 
				onclick="location.href='<%=request.getContextPath() %>/login/logout.jsp?bidx=<%=bidxH %>&nowPage=<%=nowPageH %>&searchType=<%=searchTypeH%>&searchValue=<%=searchValueH%>'">
				<input type="button" name="mypage" value="마이페이지" 
				onclick="location.href='<%=request.getContextPath() %>/member/mypage.jsp'">
			</div>
	<%	}else if(m != null && m.getGrade().equals("A")){ 
	%>		<div>
				<span><%=m.getMembername() %>님 환영합니다</span><br>
				<input type="button" name="logout" value="로그아웃" 
				onclick="location.href='<%=request.getContextPath() %>/login/logout.jsp?bidx=<%=bidxH %>&nowPage=<%=nowPageH %>&searchType=<%=searchTypeH%>&searchValue=<%=searchValueH%>'">
				<input type="button" name="manageMember" value="회원 관리" 
				onclick="location.href='<%=request.getContextPath() %>/management/management.jsp'">
				<input type="button" name="manageBoard" value="게시물 관리" 
				onclick="location.href='<%=request.getContextPath() %>/management/manageBoard.jsp'">
			</div>
	<%	} 
	%>
	<h2 id="top"><a href="<%=request.getContextPath() %>">게시판</a></h2>
</header>