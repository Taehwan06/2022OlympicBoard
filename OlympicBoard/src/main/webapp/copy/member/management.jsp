<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");

	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null || !loginUser.getGrade().equals("A")){
		response.sendRedirect(request.getContextPath());
	}
	
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
</head>
<body>
	<div id="searchBox">
		<form name="searchFrm" action="list.jsp">
				<select name="searchType">
					<option value="subjectContent"
					<%if(searchType != null && !searchType.equals("") && searchType.equals("subjectContent")) 
						out.print("selected"); %>>제목+내용</option>
					<option value="writer"
					<%if(searchType != null && !searchType.equals("") && searchType.equals("writer")) 
						out.print("selected"); %>>작성자</option>
					<option value="subject"
					<%if(searchType != null && !searchType.equals("") && searchType.equals("subject")) 
						out.print("selected"); %>>제목</option>
					<option value="content"
					<%if(searchType != null && !searchType.equals("") && searchType.equals("content")) 
						out.print("selected"); %>>내용</option>					
				</select>
				<div>
					<input type="text" name="searchValue" size="20"
					<%if(searchValue != null && !searchValue.equals("") && 
					!searchValue.equals("null")) out.print("value='"+searchValue+"'"); %>>
					<input type="submit" name="searchSubmit" value="검색">
				</div>
			</form>
	</div>
	<div id="box">
		<div id="head" class="border">
			<span id="headNo" class="no">회원 번호</span>
			<span id="headName" class="name">성명</span>
			<span id="headId" class="id">아이디</span>
			<span id="headGrade" class="grade">회원 등급</span>
			<span id="headWcnt" class="wcnt">작성 게시글 수</span>
			<span id="headEdate" class="edate">가입일</span>
		</div>
	</div>
</body>
</html>