<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String bidx = request.getParameter("bidx");

	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath()+"/board/view.jsp?bidx="+bidx);
	}
	
	Board board = (Board)session.getAttribute("board");
	
	ListPageData listPageData = (ListPageData)session.getAttribute("listPageData");
	String searchValue = null;
	String searchType = null;
	String nowPage = null;
	if(listPageData != null){
		searchType = listPageData.getSearchType();
		searchValue = listPageData.getSearchValue();
		nowPage = listPageData.getNowPage();
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/modify.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	function modifyFn(){
		document.modifyFrm.method = "post";
		document.modifyFrm.action = "modifyOk.jsp";
		document.modifyFrm.submit();
	}

	function cancelFn(){
		location.href = "view.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue%>&nowPage=<%=nowPage %>&bidx=<%=bidx %>";
	}
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<form id="modifyFrm" name="modifyFrm">	
			<input type="hidden" name="bidx" value="<%=bidx %>">
			<div class="box">
				<label for="subject"><div id="subjectTop">제목</div></label>
				<input type="text" id="subject" name="subject" 
				value="<%=board.getBsubject() %>" placeholder="제목을 입력하세요.">
			</div>
			<div class="box">
				<label for="writer"><div id="writerTop">작성자</div></label>
				<input type="text" id="writer" name="writer" 
				value="<%=board.getBwriter() %>" readonly>
			</div>
			<div class="box">
				<label for="content"><div id="contentTop">내용</div></label>
				<textarea id="content" name="content" 
				placeholder="내용을 입력하세요."><%=board.getBcontent() %></textarea>
			</div>
		</form>
	
		<div id="buttonBox">
			<input type="button" id="modifySubmit" name="modifySubmit" 
			value="저장" onclick="modifyFn()">
			<input type="button" id="cancel" name="cancel" 
			value="취소" onclick="cancelFn()">
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>