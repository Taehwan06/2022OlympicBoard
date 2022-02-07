<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%@ include file="/scriptlet/viewScriptlet.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 상세보기</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/view.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	var sT = "<%=searchType %>";
	var sV = "<%=searchValue %>";
	function reSubmitFn(){
		$.ajax({
			url: "replyInsert.jsp",
			type: "post",
			data: $("#reSubmitFrm").serialize(),
			success: function(data){
				var json = JSON.parse(data.trim());
				var html = "";
				html += "<div id='reArea'>";
				html += "<span id='rename'>"+json[0].rwriter+"</span>";
				html += "<span id='redate'>"+json[0].rwdate+"</span><br>";
				html += "<span id='recon'>"+json[0].rcontent+"</span>";
				html += "</div>";
				
				$("#replyBox").append(html);
				document.reSubmitFrm.reset();
			}
		});
	}
	
	function reDeleteFn(ridx,obj){
		$.ajax({
			url: "replyDelete.jsp",
			type: "post",
			data: "ridx="+ridx,
			success: function(data){				
				var result = data.trim();
				if(result>0){
					obj.style.display = "none";					
				}
			}
		});
	}
</script>
<script src="<%=request.getContextPath() %>/js/view.js"></script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div>			
			<table border=1>		
				<tbody>
					<tr>
						<td>제목</td>
						<td><%=board.getBsubject() %></td>
					<tr>
					<tr>
						<td>작성자</td>
						<td><%=board.getBwriter() %></td>
					<tr>
					<tr>
						<td>작성일</td>
						<td><%=board.getBwdate() %></td>
					<tr>
					<tr>
						<td>조회수</td>
						<td><%=board.getBhit() %></td>
					<tr>
					<tr>	
						<td colspan="2"><%=board.getBcontent() %></td>
					<tr>
					<tr>
						<td colspan="2">추천</td>
					<tr>
				</tbody>
			</table>
			<div id="buttonDiv">
		<%	if(loginUser != null && loginUser.getMidx() == board.getMidx()){ 
		%>		<input type="button" id="modifyButton" value="수정" onclick="modifyFn()">
				<input type="button" id="deleteButton" value="삭제" onclick="deleteFn()">
		<%	}
		%>		<input type="button" id="listButton" value="목록" onclick="listFn()">
			</div>
			<div id="reInputArea">		
				<form id="reSubmitFrm" name="reSubmitFrm">
					<input type="hidden" name="bidx" value="<%=bidx %>">
		<%	if(loginUser == null){
		%>			<input type="text" name="reInput" id="reInput" size=30 
					maxlength=500 placeholder="댓글을 작성하려면 로그인 해주세요" readonly>
					<input type="button" name="reSubmitButton" id="reSubmitButton" 
					value="등록">
		<%	}else if(loginUser != null){
		%>			<input type="text" name="reInput" id="reInput" size=30 
					maxlength=500 placeholder="댓글을 작성하려면 내용을 입력하세요">
					<input type="button" name="reSubmitButton" id="reSubmitButton" 
					value="등록" onclick="reSubmitFn()">
		<%	}
		%>		</form>
			</div>
			<div id="reBox">
		<%	for(Reply r : rList){				
		%>		<div id="reArea">					
					<span id="rename"><%=r.getRwriter() %></span>
					<span id="redate"><%=r.getRwdate() %></span>
			<%	if(loginUser != null && loginUser.getMidx() == r.getMidx() && r.getRdelyn().equals("N")){
			%>		<input type="button" value="삭제" id="redel" onclick="reDeleteFn(<%=r.getRidx() %>,this)">						
			<%	}
			%>		<br>
			<%	if(r.getRdelyn().equals("Y")){
			%>		<span id="recon" style="color:gray">삭제된 댓글입니다.</span>
			<%	}else if(r.getRdelyn().equals("N")){
			%>		<span id="recon"><%=r.getRcontent() %></span>
			<%	}
			%>	</div>
		<%	}
		%>	</div>
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	
%>