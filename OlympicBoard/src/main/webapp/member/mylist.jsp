<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.S");
%>
<%	
	request.setCharacterEncoding("UTF-8");
	
	String midx = request.getParameter("midx");
	
	Member memberMidx = new Member();
	
	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}else{
		memberMidx.setMidx(loginUser.getMidx());
		session.setAttribute("memberMidx",memberMidx);
		
		Check check = (Check)session.getAttribute("check");
		
		String searchType = request.getParameter("searchType");
		String searchValue = request.getParameter("searchValue");
		
		Notice notice = new Notice();
		
		String nowPage = request.getParameter("nowPage");
		int nowPageI = 1;
		if(nowPage != null && !nowPage.equals("") && !nowPage.equals("null")){
			nowPageI = Integer.parseInt(nowPage);
		}
		
		ListPageData listPageData = new ListPageData();
		listPageData.setSearchType(searchType);
		listPageData.setSearchValue(searchValue);
		listPageData.setNowPage(Integer.toString(nowPageI));
		session.setAttribute("listPageData", listPageData);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		ArrayList<Board> boardNoticeA = new ArrayList<>();
		
		PagingUtil paging = null;
		
		try{
			conn = DBManager.getConnection();
			
			String sql = "select count(*) as total from board where bdelyn='N' and midx=? ";
			
			if(searchValue != null && !searchValue.equals("")){
				if(searchType.equals("writer")){
					sql += " and bwriter = '"+searchValue+"' ";
				}else if(searchType.equals("subject")){
					sql += " and bsubject like '%"+searchValue+"%' ";
				}else if(searchType.equals("content")){
					sql += " and bcontent like '%"+searchValue+"%' ";
				}else if(searchType.equals("subjectContent")){
					sql += " and bcontent like '%"+searchValue+"%' ";
					sql += " or (midx='"+midx+"' and bsubject like '%"+searchValue+"%') ";
				}			
			}
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,midx);
			
			rs = psmt.executeQuery();
			
			int total = 0;
			
			if(rs.next()){
				total = rs.getInt("total");
			}
			
			paging = new PagingUtil(total,nowPageI,10);		
			
			sql = " select * from ";
			sql += " (select rownum r , b.* from ";		
			sql += "(SELECT * FROM board where bdelyn='N' and midx=? "; 
			
			if(searchValue != null && !searchValue.equals("")){
				if(searchType.equals("writer")){
					sql += " and bwriter = '"+searchValue+"' ";
				}else if(searchType.equals("subject")){
					sql += " and bsubject like '%"+searchValue+"%' ";
				}else if(searchType.equals("content")){
					sql += " and bcontent like '%"+searchValue+"%' ";
				}else if(searchType.equals("subjectContent")){
					sql += " and bcontent like '%"+searchValue+"%' ";
					sql += " or (midx='"+midx+"' and bsubject like '%"+searchValue+"%') ";
				}			
			}
			
			sql += " order by bidx desc ) b) ";
			sql += " where r>="+paging.getStart()+" and r<="+paging.getEnd();
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,midx);
			
			
			rs = psmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 작성한 글 목록</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/list.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	<%	if(check != null){
			if(check.getLoginNull() != null && check.getLoginNull().equals("null")){
	%>			alert("로그인 후 이용 가능합니다.");
	<%		}
	}
	%>
	
	function viewFn(bidx){
		location.href="myview.jsp?bidx="+bidx+"&nowPage=<%=paging.getNowPage() %>&searchType=<%=searchType %>&searchValue=<%=searchValue %>";
	}
	
	function searchFn(){
		document.searchFrm.method = "get";
		document.searchFrm.action = "mylist.jsp";
		document.searchFrm.submit();
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
			<form name="searchFrm">
				<input type="hidden" name="midx" value="<%=midx %>">
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
					<input type="button" name="searchSubmit" value="검색" onclick="searchFn()">
				</div>
			</form>
			<div id="box">
				<div id="titleRow">
					<span class="bidxSpan">글번호</span>
					<span class="subjectSpan">제목</span>
					<span class="writerSpan">작성자</span>					
					<span class="wdateSpan">작성일</span>
					<span class="hitSpan">조회수</span>
					<span class="upSpan">추천</span>
				</div>
			<%	while(rs.next()){
				notice.setListWritedate(rs.getString("bwdate"));
		%>		<div class="rowDiv" onclick="viewFn(<%=rs.getInt("bidx") %>)">
					<span class="bidxSpan"><%=rs.getInt("bidx") %></span>
					<span class="subjectSpan" <% if(rs.getString("bnotice").equals("Y")){ out.print("style='color:red'"); } %>>
						<%	if(rs.getString("bnotice").equals("Y")){ out.print("<b>[공지] "); } %>
						<%=rs.getString("bsubject") %> 
						<%	if(rs.getInt("recnt")>0){ 
						%>		[<%=rs.getInt("recnt") %>]
						<%	} 
						%>
						<%	if(rs.getString("bnotice").equals("Y")){ out.print("</b>"); } %>
					</span>
					<span class="writerSpan"><%=rs.getString("bwriter") %></span>
					<span class="wdateSpan">
				<%		notice.setSplitDate(rs.getString("bwdate"));
						notice.setNowdate(sf.format(nowTime));
						notice.setListWritedate(rs.getString("bwdate"));
						notice.setListWritedate2(rs.getString("bwdate"));
						if(notice.getSplitDate().equals(notice.getNowdate())){
							out.print(notice.getListWritedate());
						}else{
							out.print(notice.getListWritedate2());
						}
				%>	</span>
					<span class="hitSpan"><%=rs.getInt("bhit") %></span>
					<span class="upSpan"><%=rs.getInt("up") %></span>
				</div>
		<%	}
		%>	</div>		
			<div id="pagingArea">
			<% 	if(paging.getStartPage() > 1){
			%>		<input type="button" class="backButton" value="이전" 
					onclick="location.href='mylist.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>&midx=<%=midx%>'">
			<%	}
				for(int i= paging.getStartPage(); i<=paging.getEndPage(); i++){
					if(i == paging.getNowPage()){
			%>			<input type="button" class="selButton" value="<%=i%>" 
						onclick="location.href='mylist.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>&midx=<%=midx%>'">
			<%		}else{
			%>			<input type="button" class="numButton" value="<%=i%>" 
						onclick="location.href='mylist.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>&midx=<%=midx%>'">
			<%		}
				}						
			 	if(paging.getEndPage() != paging.getLastPage()){
			%>		<input type="button" class="nextButton" value="다음" 
					onclick="location.href='mylist.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>&midx=<%=midx%>'">
			<%	}
			%>			
			</div>
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(psmt,conn,rs);
		}
	}
%>