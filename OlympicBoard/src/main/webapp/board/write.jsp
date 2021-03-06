<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	String writer = "";

	Check check = new Check();
	
	ReUrl reurl = new ReUrl();
	String url = request.getContextPath();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		check.setLoginNull("null");
		session.setAttribute("check",check);
		response.sendRedirect(request.getContextPath()+"/board/list.jsp");
	}else{
		writer = loginUser.getMembername();
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
		$("#content").html($("#content2").html());
		if($("#subject").val() != null && $("#content").val() != null && $("#subject").val() != "" && $("#content").val() != ""){
			document.writeFrm.method = "post";
			document.writeFrm.action = "writeOk.jsp";
			document.writeFrm.submit();
		}else{
			alert("제목과 내용을 입력해주세요.");
		}
		
	}
	
	function cancelFn(){
		location.href = "list.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue%>&nowPage=<%=nowPage %>";
	}
	
	function fileFrm1Fn(obj){
		var form = $("#fileFrm1")[0];
	    var formData = new FormData(form);
	    $.ajax({
			url: "fileFrm1.jsp",
			type: "post",
			data: formData,
			enctype: "multipart/form-data",
			contentType: false,
			processData: false,
			success: function(data){
				var imgsys = data.trim();
				setTimeout(() => sleep(), 1000);
				function sleep(){
					$("#content2").append(imgsys);
				}
				obj.style.display = "none";
	        }
	    });
	}
	
	function fileFrm2Fn(obj){
		var form = $("#fileFrm2")[0];
	    var formData = new FormData(form);
	    $.ajax({
			url: "fileFrm2.jsp",
			type: "post",
			data: formData,
			enctype: "multipart/form-data",
			contentType: false,
			processData: false,
			success: function(data){
				var imgsys = data.trim();
				setTimeout(() => sleep(), 1000);
				function sleep(){
					$("#content2").append(imgsys);
				}
				obj.style.display = "none";
	        }
	    });
	}
	
	function fileFrm3Fn(obj){
		var form = $("#fileFrm3")[0];
	    var formData = new FormData(form);
	    $.ajax({
			url: "fileFrm3.jsp",
			type: "post",
			data: formData,
			enctype: "multipart/form-data",
			contentType: false,
			processData: false,
			success: function(data){
				var imgsys = data.trim();
				setTimeout(() => sleep(), 1000);
				function sleep(){
					$("#content2").append(imgsys);
				}
				obj.style.display = "none";
	        }
	    });
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
		<form id="writeFrm" name="writeFrm">
	<%	if(loginUser.getGrade().equals("A")){
	%>		<div class="noticeBox">
				<label for="notice"><div id="noticeTop">게시글 종류</div></label>
				<select id="notice" name="notice">
					<option value="N">일반 게시글</option>
					<option value="Y">공지사항</option>
				</select>
			</div>
	<%	}
	%>
			<div class="box">
				<label for="subject"><div id="subjectTop">제목</div></label>
				<input type="text" id="subject" name="subject" 
				placeholder="제목을 입력하세요.">
			</div>
			<div class="box">
				<label for="writer"><div id="writerTop">작성자</div></label>
				<input type="text" id="writer" name="writer" 
				value="<%=writer %>" readonly>
			</div>
			<div class="box">
				<label for="content2"><div id="contentTop">내용</div></label>
				<textarea id="content" name="content" 
				placeholder="내용을 입력하세요."></textarea>
				<div id="content2" contentEditable="true" placeholder="내용을 입력하세요."></div>
			</div>
		</form>
		<form name="fileFrm1" id="fileFrm1" action="fileFrm1.jsp" method="post" enctype="multipart/form-data">
			<div class="fileTop">첫 번째 이미지 추가하기
				<input type="file" name="file1" id="file1">
				<input type="button" name="submit1" id="submit1" value="이미지 첨부" onclick="fileFrm1Fn(this)">
			</div>			
		</form>
		<form name="fileFrm2" id="fileFrm2" action="fileFrm2.jsp" method="post" enctype="multipart/form-data">
			<div class="fileTop">두 번째 이미지 추가하기
				<input type="file" name="file2" id="file2">
				<input type="button" name="submit2" id="submit2" value="이미지 첨부" onclick="fileFrm2Fn(this)">
			</div>			
		</form>
		<form name="fileFrm3" id="fileFrm3" action="fileFrm3.jsp" method="post" enctype="multipart/form-data">
			<div class="fileTop">세 번째 이미지 추가하기
				<input type="file" name="file3" id="file3">
				<input type="button" name="submit3" id="submit3" value="이미지 첨부" onclick="fileFrm3Fn(this)">
			</div>			
		</form>
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