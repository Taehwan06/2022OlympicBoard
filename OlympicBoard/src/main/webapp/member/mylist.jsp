<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%	
	request.setCharacterEncoding("UTF-8");
	
	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}else{
		int midx = loginUser.getMidx();
	
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
					sql += " or bsubject like '%"+searchValue+"%' ";
				}			
			}
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,midx);
			
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
					sql += " or bsubject like '%"+searchValue+"%' ";
				}			
			}
			
			sql += " order by bidx desc ) b) ";
			sql += " where r>="+paging.getStart()+" and r<="+paging.getEnd();
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,midx);
			
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
			<form name="searchFrm" action="mylist.jsp">
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
					<input type="submit" name="searchSubmit" value="검색">
				</div>
			</form>
			<table border=1>
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>추천</th>
					</tr>
				</thead>
				<tbody>
			<%	while(rs.next()){
					notice.setListWritedate(rs.getString("bwdate"));
			%>		<tr>
						<td><%=rs.getInt("bidx") %></td>
						<td><a href="myview.jsp?nowPage=<%=paging.getNowPage() %>&bidx=<%=rs.getInt("bidx") %>
									&searchType=<%=searchType %>&searchValue=<%=searchValue %>">
						<%=rs.getString("bsubject") %> 
						<%	if(rs.getInt("recnt")>0){ 
						%>		[<%=rs.getInt("recnt") %>]
						<%	} 
						%></a></td>
						<td><%=rs.getString("bwriter") %></td>
						<td><%=notice.getListWritedate() %></td>
						<td><%=rs.getInt("bhit") %></td>
						<td><%=rs.getInt("up") %></td>
					<tr>
			<%	}
			%>	</tbody>				
			</table>		
			<div id="pagingArea">
			<% 	if(paging.getStartPage() > 1){
			%>		<input type="button" class="backButton" value="이전" 
					onclick="location.href='mylist.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
			<%	}
				for(int i= paging.getStartPage(); i<=paging.getEndPage(); i++){
					if(i == paging.getNowPage()){
			%>			<input type="button" class="selButton" value="<%=i%>" 
						onclick="location.href='mylist.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
			<%		}else{
			%>			<input type="button" class="numButton" value="<%=i%>" 
						onclick="location.href='mylist.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
			<%		}
				}						
			 	if(paging.getEndPage() != paging.getLastPage()){
			%>		<input type="button" class="nextButton" value="다음" 
					onclick="location.href='mylist.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
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