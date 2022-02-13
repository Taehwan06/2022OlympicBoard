<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");

	String bidx = request.getParameter("bidx");
	String nowPage = request.getParameter("nowPage");
	String searchValue = request.getParameter("searchValue");
	String searchType = request.getParameter("searchType");
	
	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
	ListPageData listPageData = new ListPageData();
	if(session.getAttribute("listPageData") != null){
		listPageData = (ListPageData)session.getAttribute("listPageData");
	}
	
	if(listPageData != null && listPageData.getSearchType() != null && listPageData.getSearchValue() != null){
		searchType = listPageData.getSearchType();
		searchValue = listPageData.getSearchValue();
	}
	
	listPageData.setSearchType(searchType);
	listPageData.setSearchValue(searchValue);
	listPageData.setNowPage(nowPage);
	session.setAttribute("listPageData",listPageData);
	
	Check check = (Check)session.getAttribute("check");
	
	Notice notice = new Notice();
	
	Board board = new Board();
	ArrayList<Reply> rList = new ArrayList<>();
	
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
			String sql = "";
			
			sql = "select * from board where bidx=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,bidx);		
			
			rs = psmt.executeQuery();		
			
			if(rs.next()){
				board.setBidx(rs.getInt("bidx"));
				board.setMidx(rs.getInt("midx"));
				board.setBhit(rs.getInt("bhit"));
				board.setRecnt(rs.getInt("recnt"));
				board.setBwriter(rs.getString("bwriter"));
				board.setBsubject(rs.getString("bsubject"));
				board.setBcontent(rs.getString("bcontent"));
				board.setBwdate(rs.getString("bwdate"));
				board.setUp(rs.getInt("up"));
				session.setAttribute("board",board);
			}
			
			sql = "select * from reply where bidx=? order by ridx";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,bidx);
			
			rs = psmt.executeQuery();
				
			while(rs.next()){
				Reply reply = new Reply();
				reply.setRidx(rs.getInt("ridx"));
				reply.setBidx(rs.getInt("bidx"));
				reply.setMidx(rs.getInt("midx"));
				reply.setRwriter(rs.getString("rwriter"));
				reply.setRwdate(rs.getString("rwdate"));
				reply.setRcontent(rs.getString("rcontent"));
				reply.setRdelyn(rs.getString("rdelyn"));
				
				rList.add(reply);
			}
				
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(psmt,conn,rs);		
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 작성한 게시글 상세보기</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/view.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath() %>/js/view.js"></script>
<script>
	<%	if(check != null){
			if(check.getModifyCheck() != null && check.getModifyCheck().equals("success")){
	%>			alert("수정이 완료되었습니다.");
	<%		}else if(check.getModifyCheck() != null && check.getModifyCheck().equals("fail")){
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
				url: "<%=request.getContextPath() %>/board/replyInsert.jsp",
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
				url: "<%=request.getContextPath() %>/board/replyDelete.jsp",
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
	
	function modifyFn(){
		location.href = "myModify.jsp?bidx=<%=bidx %>";
	}
	
	function deleteFn(){
		var con = confirm("게시글을 삭제하시겠습니까?");		
		if(con){
			location.href = "myDelete.jsp?bidx=<%=bidx %>";
		}
	}
	
	function listFn(){
		location.href="mylist.jsp?searchType="+sT+"&searchValue="+sV+"&nowPage="+nowPage;	
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
							<input type="button" id="up" value="추천" disabled>
							<span id="upVal"><%=board.getUp() %></span>
							<input type="button" id="down" value="비추천" disabled>
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