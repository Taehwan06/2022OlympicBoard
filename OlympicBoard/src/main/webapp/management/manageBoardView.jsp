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
	
	ReUrl reurl = new ReUrl();
	String url = request.getContextPath();
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
	
	String replyNowPage = request.getParameter("replyNowPage");
	int replyNowPageI = 1;
	if(replyNowPage != null && !replyNowPage.equals("") && !replyNowPage.equals("null")){
		replyNowPageI = Integer.parseInt(replyNowPage);
	}
	
	PagingUtil replyPaging = null;
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}else{
		if(!loginUser.getGrade().equals("A")){
			response.sendRedirect(request.getContextPath());
		}else{
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
	
			try{
				conn = DBManager.getConnection();
				
				String sql = "select * from board where bidx=?";
				
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
					board.setBdelyn(rs.getString("bdelyn"));
					board.setBimgori(rs.getString("bimgori"));
					board.setBimgsys(rs.getString("bimgsys"));
					board.setBimgori2(rs.getString("bimgori2"));
					board.setBimgsys2(rs.getString("bimgsys2"));
					board.setBimgori3(rs.getString("bimgori3"));
					board.setBimgsys3(rs.getString("bimgsys3"));
					board.setBnotice(rs.getString("bnotice"));
					board.setBmdate(rs.getString("bmdate"));
					
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
				sql += " order by originridx, depth) b) ";
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
					reply.setLvl(rs.getInt("lvl"));
					reply.setRmdate(rs.getString("rmdate"));
					
					rList.add(reply);
				}
					
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				DBManager.close(psmt,conn,rs);		
			}
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 조회</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/view.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath() %>/js/view.js"></script>
<script>
	<%	if(check != null && check.getModifyCheck() != null && check.getModifyCheck().equals("success")){
	%>		alert("<%=board.getBidx() %>번 게시물이 수정되었습니다.");
	<%	}else if(check != null && check.getWithdraw() != null && check.getWithdraw().equals("fail")){
	%>		alert("<%=board.getBidx() %>번 게시물의 수정이 실패했습니다.");
	<%	}
		if(check != null && check.getRestore() != null && check.getRestore().equals("success")){
	%>		alert("<%=board.getBidx() %>번 게시물의 복구가 완료되었습니다.");
	<%	}else if(check != null && check.getRestore() != null && check.getRestore().equals("fail")){
	%>		alert("<%=board.getBidx() %>번 게시물의 복구가 실패했습니다.");
	<%	}
		if(check != null && check.getDeleteBoardCheck() != null && check.getDeleteBoardCheck().equals("success")){
	%>		alert("<%=board.getBidx() %>번 게시물이 삭제되었습니다.");
	<%	}else if(check != null && check.getDeleteBoardCheck() != null && check.getDeleteBoardCheck().equals("fail")){
	%>		alert("<%=board.getBidx() %>번 게시물의 삭제가 실패했습니다.");
	<%	}
	%>

	var sT = "<%=searchType %>";
	var sV = "<%=searchValue %>";
	var bidx = "<%=bidx %>";
	var nowPage = "<%=nowPage %>";
	
	function reReSubmitFn(obj){
		var reVal = $(obj).prev().val();
		if(reVal != null && reVal != ""){
			$.ajax({
				url: "reReplyInsert.jsp",
				type: "post",
				data: $(obj).parent().serialize(),
				success: function(data){
					var json = JSON.parse(data.trim());
					var lvl = json[0].lvl;
					var html = "";
					
					html += "<div class='reArea'>";
					
					if(lvl > 0){
						for(var i=0; i < lvl; i++){
							html += "<span style='width:20px'><img src='"+url+"/upload/replyImg5.png'></span>";
						}
					}
					
					html += "<span id='rename'>"+json[0].rwriter+"</span> ";
					html += "<span id='redate'>"+json[0].rwdate+"</span> ";
					html += "<input type='button' value='삭제' id='redel' onclick='reDeleteFn("+json[0].ridx+",this)'> ";
					html += "<input type='button' value='수정' id='remodi' onclick='reModifyFn("+json[0].ridx+",this)'> ";
					html += "<input type='button' value='저장' id='resave' onclick='reSaveFn("+json[0].ridx+",this)'> ";
					html += "<input type='button' value='취소' id='recan' onclick='reCancelFn("+json[0].ridx+",this)'> ";
					html += "<br>";
					html += "<span id='recon'><pre>"+json[0].rcontent+"</pre></span>";
					html += "<form id='remodiFrm' name='remodiFrm'>";
					html += "<textarea name='reModifyInsert' id='reModifyInsert'></textarea>";
					html += "<input type='hidden' name='ridx' value='"+json[0].ridx+"'>";
					html += "</form>";
					html += "<input type='button' value='댓글' id='reReply' onclick='reReplyFn("+json[0].ridx+",this)'>";
					html += "<input type='button' value='취소' id='reReCan' onclick='reReCanFn(this)'>";
					html += "</div>";
					
					$(obj).parent().parent().after(html);
					$(obj).parent().prev().css("display","none");
					$(obj).parent().prev().prev().css("display","inline-block");
					$(obj).parent().remove();
					alert("댓글이 등록되었습니다.");
				}
			});
		}else{
			alert("댓글 내용을 입력해주세요.");
		}
	}
	
	function reReplyFn(ridx,obj){
		var html = "";
		html += "<form id='reRsSubmitFrm' name='reReSubmitFrm'>";
		html += "<input type='hidden' name='bidx' value='"+bidx+"'>";
		html += "<input type='hidden' name='parentridx' value='"+ridx+"'>";
		html += "<textarea name='reReInput' id='reReInput' placeholder='댓글을 작성하려면 내용을 입력하세요'></textarea>";
		html += "<input type='button' name='reReSubmitButton' id='reReSubmitButton' value='등록' onclick='reReSubmitFn(this)'>";
		html += "</from>";
		
		$(obj).parent().append(html);
		$(obj).next().css("display","inline-block");
		$(obj).css("display","none");
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
						$(obj).next().next().next().next().next().children().text("삭제된 댓글입니다.");
						$(obj).next().next().next().next().next().children().css("color","gray");
						$(obj).next().next().next().next().next().next().next().css("display","none");
						$(obj).next().css("display","none");
						$(obj).css("display","none");
						alert("댓글이 삭제되었습니다.");
					}
				}
			});
		}
	}
	
	function reModifyFn(ridx,obj){
		$(obj).prev().css("display","none");
		$(obj).next().css("display","inline-block");
		$(obj).next().next().css("display","inline-block");
		$(obj).next().next().next().next().next().children().css("display","inline-block");
		$(obj).next().next().next().next().next().next().css("display","none");
		var text = $(obj).next().next().next().next().children().text();		
		$(obj).next().next().next().next().next().children().text(text);
		$(obj).next().next().next().next().css("display","none");
		$(obj).css("display","none");
	}
	
	function reSaveFn(ridx,obj){
		$.ajax({
			url: "replyModify.jsp",
			type: "post",
			data: $(obj).next().next().next().next().serialize(),
			success: function(data){
				var json = JSON.parse(data.trim());
				$(obj).next().next().next().next().next().css("display","inline-block");
				$(obj).next().next().next().children().text(json[0].rcontent);
				$(obj).next().next().next().css("display","inline-block");
				$(obj).next().next().next().next().children().css("display","none");
				$(obj).prev().css("display","inline-block");
				$(obj).prev().prev().css("display","inline-block");
				$(obj).next().css("display","none");
				$(obj).css("display","none");
			}
		});
	}
	
	function reCancelFn(ridx,obj){
		$(obj).next().next().next().next().css("display","inline-block");
		$(obj).prev().css("display","none");
		$(obj).prev().prev().css("display","inline-block");
		$(obj).prev().prev().prev().css("display","inline-block");
		$(obj).next().next().css("display","inline-block");
		$(obj).next().next().next().children().css("display","none");
		$(obj).css("display","none");
	}
	
	function reReCanFn(obj){
		$(obj).next().remove();
		$(obj).prev().css("display","inline-block");
		$(obj).css("display","none");
	}
	
	function replyRestoreFn(ridx,obj){
		var con = confirm("댓글을 복구하시겠습니까?");
		if(con){
			$.ajax({
				url: "replyRestore.jsp",
				type: "post",
				data: "ridx="+ridx+"&bidx="+bidx,
				success: function(data){				
					var json = JSON.parse(data.trim());
					obj.style.display = "none";
					obj.parentElement.lastElementChild.textContent = json[0].rcontent;
					obj.parentElement.lastElementChild.style.color = "black";
					alert("댓글이 복구되었습니다.");
				}
			});
		}
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
		location.href="manageBoard.jsp?searchType="+sT+"&searchValue="+sV+"&nowPage="+nowPage;
	}
	
	function restoreFn(){
		var con = confirm("게시글을 복구하시겠습니까?");
		if(con){
			location.href="restoreBoard.jsp?bidx=<%=bidx %>&searchType="+sT+"&searchValue="+sV+"&nowPage="+nowPage;
		}
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
		<%	if(board.getBmdate() != null){
		%>		<div class="modifyDiv">
					<%=board.getBmdate() %>에 마지막으로 수정됨.
				</div>
		<%	}
		%>
				<div class="contentDiv">
		<%		if(board.getBimgori() != null && board.getBimgsys() != null){
		%>			<div class="fileDiv">
						첨부파일 : <%=board.getBimgori() %>
					</div>
		<%		}
				if(board.getBimgori2() != null && board.getBimgsys2() != null){
		%>			<div class="fileDiv">
						첨부파일 : <%=board.getBimgori2() %>
					</div>
		<%		}
				if(board.getBimgori3() != null && board.getBimgsys3() != null){
		%>			<div class="fileDiv">
						첨부파일 : <%=board.getBimgori3() %>
					</div>
		<%		}
		%>		</div>
				<div class="contentDiv">
					<pre><%=board.getBcontent() %></pre>
				</div>
				<div id="upAreaDiv" class="rowDiv">
					<span id="upVal"><%=board.getUp() %></span>
				</div>
			</div>
			
			<div id="buttonDiv">
		<%	if(board.getBdelyn().equals("N")){
		%>		<input type="button" id="modifyButton" value="수정" onclick="modifyFn()">
				<input type="button" id="deleteButton" value="삭제" onclick="deleteFn()">
		<%	}else if(board.getBdelyn().equals("Y")){
		%>		<input type="button" id="restoreButton" value="복구" onclick="restoreFn()">
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
		%>		
				<div class="reArea">
		<%		if(r.getLvl()>0){
					for(int i=0; i<r.getLvl()-1; i++){
		%>				<span class="reSpanSpace"></span>
		<%			}
					for(int i=r.getLvl()-1; i<r.getLvl(); i++){
		%>				<span class="reSpan">&#8627</span>
		<%			}
				}	
		%>			<div class="reIn">
						<span id="rename"><%=r.getRwriter() %></span>
						<span id="redate"><%=r.getRwdate() %></span>
		<%		if(r.getRdelyn().equals("N")){
		%>				<input type="button" value="삭제" id="redel" onclick="reDeleteFn(<%=r.getRidx() %>,this)">
						<input type="button" value="수정" id="remodi" onclick="reModifyFn(<%=r.getRidx() %>,this)">
						<input type="button" value="저장" id="resave" onclick="reSaveFn(<%=r.getRidx() %>,this)">
						<input type="button" value="취소" id="recan" onclick="reCancelFn(<%=r.getRidx() %>,this)">
		<%		}
		%>		
		<%		if(r.getRdelyn().equals("Y")){
		%>				<input type="button" value="복구" id="replyRestore" onclick="replyRestoreFn(<%=r.getRidx() %>,this)">
						<br>
						<span id="recon" style="color:gray">삭제된 댓글입니다.</span>
		<%		}else if(r.getRdelyn().equals("N")){
		%>
		<%		if(!r.getRmdate().equals("null")){
		%>				<span class="rmdate"><%=r.getRmdate() %>에 수정됨.</span>
		<%		}
		%>				<br>
						<span id="recon"><pre><%=r.getRcontent() %></pre></span>
						<form id="remodiFrm" name="remodiFrm">
							<textarea name="reModifyInsert" id="reModifyInsert"></textarea>
							<input type="hidden" name="ridx" value="<%=r.getRidx() %>">
						</form>
						<input type="button" value="댓글" id="reReply" onclick="reReplyFn(<%=r.getRidx() %>,this)">
						<input type="button" value="취소" id="reReCan" onclick="reReCanFn(this)">
		<%		}
		%>			</div>
				</div>
				
		<%	}
		%>	</div>
			<div id="pagingArea">
			<% 	if(replyPaging.getStartPage() > 1){	
			%>		<input type="button" class="backButton" value="이전" 
					onclick="location.href='manageBoardView.jsp?replyNowPage=<%=replyPaging.getStartPage()-1%>&bidx=<%=bidx %>#pagingArea'">
			<%	}
				for(int i= replyPaging.getStartPage(); i<=replyPaging.getEndPage(); i++){
					if(i == replyPaging.getNowPage()){
			%>			<input type="button" class="selButton" value="<%=i%>" 
						onclick="location.href='manageBoardView.jsp#?replyNowPage=<%=i%>&bidx=<%=bidx %>#pagingArea'">
			<%		}else{
			%>			<input type="button" class="numButton" value="<%=i%>" 
						onclick="location.href='manageBoardView.jsp?replyNowPage=<%=i%>&bidx=<%=bidx %>#pagingArea'">
			<%		}
				}						
			 	if(replyPaging.getEndPage() != replyPaging.getLastPage()){
			%>		<input type="button" class="nextButton" value="다음" 
					onclick="location.href='manageBoardView.jsp?replyNowPage=<%=replyPaging.getEndPage()+1%>&bidx=<%=bidx %>#pagingArea'">
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