<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String bidx = request.getParameter("bidx");
	String searchValue = request.getParameter("searchValue");
	String searchType = request.getParameter("searchType");
	String nowPage = request.getParameter("nowPage");

	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}
	
	Board board = (Board)session.getAttribute("board");
	
	ListPageData listPageData = new ListPageData();
	if(session.getAttribute("listPageData") != null){
		listPageData = (ListPageData)session.getAttribute("listPageData");
	}
	
	if(listPageData != null && listPageData.getSearchType() != null && listPageData.getSearchValue() != null){
		searchType = listPageData.getSearchType();
		searchValue = listPageData.getSearchValue();		
	}	
	
	if(listPageData != null && listPageData.getNowPage() != null){		
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
	$(window).bind("pageshow", function(event) {
	    if (event.originalEvent.persisted) {
	        document.location.reload();
	    }
	});

	function modifyFn(){
		document.modifyFrm.method = "post";
		document.modifyFrm.action = "myModifyOk.jsp";
		document.modifyFrm.submit();
	}

	function cancelFn(){
		location.href = "myview.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue%>&nowPage=<%=nowPage %>&bidx=<%=bidx %>";
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