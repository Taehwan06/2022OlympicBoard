<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/scriptlet/listScriptlet.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/list.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	var searchType = "<%=searchType%>";
	var searchValue = "<%=searchValue%>";
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
	nowPage : <%=nowPage %>
		<div>
			<form name="searchFrm" action="list.jsp">
				<select name="searchType">
					<option value="subjectContent"
					<%if(searchType != null && searchType.equals("subjectContent")) 
						out.print("selected"); %>>제목+내용</option>
					<option value="writer"
					<%if(searchType != null && searchType.equals("writer")) 
						out.print("selected"); %>>작성자</option>
					<option value="subject"
					<%if(searchType != null && searchType.equals("subject")) 
						out.print("selected"); %>>제목</option>
					<option value="content"
					<%if(searchType != null && searchType.equals("content")) 
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
						<td><a href="view.jsp?nowPage=<%=paging.getNowPage() %>&bidx=<%=rs.getInt("bidx") %>
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
		<%	if(loginUser != null){ 
		%>
			<div id="writeButtonDiv">
				<input type="button" id="writeButton" value="글쓰기" 
				onclick="location.href='write.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
			</div>
		<% } 
		%>
			<div id="pagingArea">
			<% 	if(paging.getStartPage() > 1){	
			%>		<input type="button" class="backButton" value="이전" 
					onclick="location.href='list.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
			<%	}
				for(int i= paging.getStartPage(); i<=paging.getEndPage(); i++){
					if(i == paging.getNowPage()){
			%>			<input type="button" class="selButton" value="<%=i%>" 
						onclick="location.href='list.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
			<%		}else{
			%>			<input type="button" class="numButton" value="<%=i%>" 
						onclick="location.href='list.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
			<%		}
				}						
			 	if(paging.getEndPage() != paging.getLastPage()){
			%>		<input type="button" class="nextButton" value="다음" 
					onclick="location.href='list.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
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
%>