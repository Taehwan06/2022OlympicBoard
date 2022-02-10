<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="/scriptlet/viewScriptlet.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/view.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath() %>/js/view.js"></script>
<script>
	<%	if(check != null){
			if(check.getModifyCheck().equals("success")){
	%>			alert("수정이 완료되었습니다.");
	<%		}else if(check.getModifyCheck().equals("fail")){
	%>			alert("수정이 실패했습니다.");
	<%		}
		}
	%>

	var sT = "<%=searchType %>";
	var sV = "<%=searchValue %>";
	var bidx = "<%=bidx %>";
	var nowPage = "<%=nowPage %>";
	
	function reSubmitFn(obj){
		var reVal = $(obj).prev().val();
		if(reVal != null && reVal != ""){
			$.ajax({
				url: "replyInsert.jsp",
				type: "post",
				data: $("#reSubmitFrm").serialize(),
				success: function(data){
					var json = JSON.parse(data.trim());
					var html = "";
					html += "<div id='reArea'>";
					html += "<span id='rename'>"+json[0].rwriter+"</span> ";
					html += "<span id='redate'>"+json[0].rwdate+"</span> ";
					html += "<input type='button' value='삭제' id='redel' onclick='reDeleteFn("+json[0].ridx+",this)'><br>";
					html += "<span id='recon'>"+json[0].rcontent+"</span>";
					html += "</div>";
					
					$("#reBox").append(html);
					document.reSubmitFrm.reset();
				}
			});
		}else{
			alert("댓글 내용을 입력해주세요.");
		}
	}
		
	function reDeleteFn(ridx,obj){
		var con = confirm("댓글을 삭제하시겠습니까?");		
		if(con){
			$.ajax({
				url: "replyDelete.jsp",
				type: "post",
				data: "ridx="+ridx+"&bidx="+bidx,
				success: function(data){				
					var result = data.trim();
					if(result>0){
						obj.style.display = "none";
						obj.parentElement.lastElementChild.textContent = "삭제된 댓글입니다.";
						obj.parentElement.lastElementChild.style.color = "gray";
					}
				}
			});
		}
	}
	
	function upFn(){
	<%	if(loginUser == null){
	%>		alert("로그인 후 이용해 주세요.");
	<%	}else{
	%>		var uplist = "<%=loginUser.getUplist() %>";
			var uplistA = uplist.split("&");
			var result = false;
			for(var i=0; i<uplistA.length; i++){
				if(uplistA[i] == bidx){
					result = true;
				}
			}
			if(result){
				alert("추천 또는 비추천은 한 번만 하실 수 있습니다.");
			}else{				
				$.ajax({
					url: "boardUp.jsp",
					type: "post",
					data: "bidx="+bidx,
					success: function(data){
						var result = data.trim();
						if(result>0){
							var value = $("#upVal").text();
							$("#up").attr("disabled",true);
							$("#down").attr("disabled",true);
							$("#up").css("border","1px solid gray");
							$("#down").css("border","1px solid gray");
							$("#upVal").text(parseInt(value)+1);
						}
					}
				});
			}
	<%	}
	%>
	}
	
	function downFn(){
	<%	if(loginUser == null){
	%>		alert("로그인 후 이용해 주세요.");
	<%	}else{
	%>		var uplist = "<%=loginUser.getUplist() %>";
			var uplistA = uplist.split("&");
			var result = false;
			for(var i=0; i<uplistA.length; i++){
				if(uplistA[i] == bidx){
					result = true;
				}
			}
			if(result){
				alert("추천 또는 비추천은 한 번만 하실 수 있습니다.");
			}else{
				$.ajax({
					url: "boardDown.jsp",
					type: "post",
					data: "bidx="+bidx,
					success: function(data){
						var result = data.trim();
						if(result>0){
							var value = $("#upVal").text();
							$("#up").attr("disabled",true);
							$("#down").attr("disabled",true);
							$("#upVal").text(parseInt(value)-1);
						}
					}
				});
			}
	<%	}
	%>
	}
	
	function modifyFn(){
		location.href = "modify.jsp?bidx=<%=board.getBidx() %>";
	}
	
	function deleteFn(){
		var con = confirm("게시글을 삭제하시겠습니까?");		
		if(con){
			location.href = "del.jsp?bidx=<%=board.getBidx() %>";
		}
	}
	
	
</script>
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
						<td colspan="2">
							<input type="button" id="up" value="추천" onclick="upFn()">
							<span id="upVal"><%=board.getUp() %></span>
							<input type="button" id="down" value="비추천" onclick="downFn()">
						</td>
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
					value="등록" onclick="reSubmitFn(this)">
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
	session.setAttribute("check",null);
%>