<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="OlympicBoard.vo.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath()+"/board/list.jsp");
	}
	
	request.setCharacterEncoding("UTF-8");
	
	String nowPage = request.getParameter("nowPage");	
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/write.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	function writeFn(){
		document.writeFrm.method = "post";
		document.writeFrm.action = "writeOk.jsp";
		document.writeFrm.submit();
	}
	
	function cancelFn(){
		location.href = "list.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue%>&nowPage=<%=nowPage %>";
	}
	
	function imgUp1Fn(){
		document.imgUpfrm1.method = "post";
		document.imgUpfrm1.enctype = "multipart/form-data";
		document.imgUpfrm1.action = "imgUp1.jsp";
		document.imgUpfrm1.submit();
	}
	
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<form id="writeFrm" name="writeFrm">			
			<div class="box">
				<label for="subject"><div id="subjectTop">제목</div></label>
				<input type="text" id="subject" name="subject" 
				placeholder="제목을 입력하세요.">
			</div>
			<div class="box">
				<label for="writer"><div id="writerTop">작성자</div></label>
				<input type="text" id="writer" name="writer" 
				value="<%=loginUser.getMembername() %>" readonly>
			</div>
			<div class="box">
				<label for="content"><div id="contentTop">내용</div></label>
				<textarea id="content" name="content" 
				placeholder="내용을 입력하세요."></textarea>
			</div>
		</form>
		<div id="imgBox">
			<form name="imgUpfrm1" id="imgUpfrm1">
				<input type="file" name="imgUp1" id="imgUp1">
				<input type="button" name="imgUp1submit" value="이미지 저장" 
				onclick="imgUp1Fn()">
			</form>
		</div>
		<div id="buttonBox">
			<input type="button" id="writeSubmit" name="writeSubmit" 
			value="등록" onclick="writeFn()">
			<input type="button" id="cancel" name="cancel" 
			value="취소" onclick="cancelFn()">
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>