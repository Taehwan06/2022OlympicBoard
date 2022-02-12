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
	int replyTotal = 0;
	
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
		
	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	Check check = (Check)session.getAttribute("check");
	
	Notice notice = new Notice();
	
	Cookie[] cookieHCA = request.getCookies();
	
	Board board = new Board();
	ArrayList<Reply> rList = new ArrayList<>();
	
	String replyNowPage = request.getParameter("replyNowPage");
	int replyNowPageI = 1;
	if(replyNowPage != null && !replyNowPage.equals("") && !replyNowPage.equals("null")){
		replyNowPageI = Integer.parseInt(replyNowPage);
	}
	
	PagingUtil replyPaging = null;

	String value = "";
	String[] valueA = null;
	boolean hitCheck = false;
	if(cookieHCA != null){
		for(Cookie cookieHC : cookieHCA){
			if(cookieHC.getName().equals("hitCheck")){
				value = cookieHC.getValue();
				valueA = value.split("&");
				for(int i=0; i<valueA.length; i++){
					if(valueA[i].equals(bidx)){
						hitCheck = true;
					}
				}
			}
		}
	}	
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		String sql = "";
		
		if(!hitCheck){
			sql = "update board set bhit=((select bhit from board where bidx=?)+1) where bidx=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,bidx);
			psmt.setString(2,bidx);
			
			int reault = psmt.executeUpdate();
			if(reault>0){
				Cookie cookieHC = new Cookie("hitCheck", value+bidx+"&");
				cookieHC.setMaxAge(60*60);
				response.addCookie(cookieHC);
			}
		}
		
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
			
			notice.setViewWritedate(rs.getString("bwdate"));
		}
		
		sql = "select count(*) as total from reply where bidx=? ";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,bidx);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			replyTotal = rs.getInt("total");
		}
		
		replyPaging = new PagingUtil(replyTotal,replyNowPageI,10);
		
		sql = " select * from ";
		sql += " (select rownum r , b.* from ";		
		sql += "(select * from reply where bidx=? ";
		sql += " order by ridx) b) ";
		sql += " where r>="+replyPaging.getStart()+" and r<="+replyPaging.getEnd();
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
%>

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
					alert("댓글이 등록되었습니다.");
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
						alert("댓글이 삭제되었습니다.");
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
		location.href = "modify.jsp?bidx=<%=bidx %>";
	}
	
	function deleteFn(){
		var con = confirm("게시글을 삭제하시겠습니까?");		
		if(con){
			location.href = "deleteBoard.jsp?bidx=<%=bidx %>";
		}
	}
	
	function listFn(){
		location.href="list.jsp?searchType="+sT+"&searchValue="+sV+"&nowPage="+nowPage;	
	}
	
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div>
			<div id="box">
				<div id="subjectDiv" class="rowDiv">
					<span id="subjectSpan" class="colSpan"><%=board.getBsubject() %></span>
				</div>
				<div id="writerDiv" class="rowDiv">
					<div id="leftDiv">
						<span id="writerSpan" class="colSpan"><%=board.getBwriter() %></span>
						<span id="wdateSpan" class="colSpan"><%=notice.getViewWritedate() %></span>
					</div>
					<div id="rightDiv">
						조회수 <span id="hitSpan" class="colSpan"><%=board.getBhit() %></span>
						추천 <span id="upSpan" class="colSpan"><%=board.getUp() %></span>
						댓글 <span id="replySpan" class="colSpan"><%=replyTotal %></span>
					</div>
				</div>
				<div id="contentDiv">
					<pre><%=board.getBcontent() %></pre>
				</div>
				<div id="upAreaDiv" class="rowDiv">
					<input type="button" id="up" value="추천" onclick="upFn()">
					<span id="upVal"><%=board.getUp() %></span>
					<input type="button" id="down" value="비추천" onclick="downFn()">
				</div>
			</div>
			
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
		%>			<textarea name="reInput" id="reInput" 
					placeholder="댓글을 작성하려면 내용을 입력하세요"></textarea>
					<input type="button" name="reSubmitButton" id="reSubmitButton" 
					value="등록">
		<%	}else if(loginUser != null){
		%>			<textarea name="reInput" id="reInput" 
					placeholder="댓글을 작성하려면 내용을 입력하세요"></textarea>
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
			<div id="pagingArea">
			<% 	if(replyPaging.getStartPage() > 1){	
			%>		<input type="button" class="backButton" value="이전" 
					onclick="location.href='view.jsp?replyNowPage=<%=replyPaging.getStartPage()-1%>&bidx=<%=bidx %>#pagingArea'">
			<%	}
				for(int i= replyPaging.getStartPage(); i<=replyPaging.getEndPage(); i++){
					if(i == replyPaging.getNowPage()){
			%>			<input type="button" class="selButton" value="<%=i%>" 
						onclick="location.href='view.jsp#?replyNowPage=<%=i%>&bidx=<%=bidx %>#pagingArea'">
			<%		}else{
			%>			<input type="button" class="numButton" value="<%=i%>" 
						onclick="location.href='view.jsp?replyNowPage=<%=i%>&bidx=<%=bidx %>#pagingArea'">
			<%		}
				}						
			 	if(replyPaging.getEndPage() != replyPaging.getLastPage()){
			%>		<input type="button" class="nextButton" value="다음" 
					onclick="location.href='view.jsp?replyNowPage=<%=replyPaging.getEndPage()+1%>&bidx=<%=bidx %>#pagingArea'">
			<%	}
			%>			
			</div>
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	session.setAttribute("check",null);
%>