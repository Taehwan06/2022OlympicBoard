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
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
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
					</tr>
				</thead>
				<tbody>
				<%	while(rs.next()){
				%>
						<tr>
							<td><%=rs.getInt("bidx") %></td>
							<td><a href="view.jsp?bidx=<%=rs.getInt("bidx") %>"
							+"&searchType=<%=searchType%>&searchValue=<%=searchValue%>">
							<%=rs.getString("bsubject") %></a></td>
							<td><%=rs.getString("bwriter") %></td>
							<td><%=rs.getString("bwdate") %></td>
							<td><%=rs.getString("bhit") %></td>
						<tr>
				<%	}
				%>
				</tbody>
			</table>
			<div id="pagingArea">
			<% 	if(paging.getStartPage() > 1){	%>
					<a href="list.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&lt;</a>	
			<%	}
				for(int i= paging.getStartPage(); i<=paging.getEndPage(); i++){
					if(i == paging.getNowPage()){
			%>
						<b><%= i %></b>
			<%		}else{
			%>
						<a href="list.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=i%></a>
			<%		}
				}
			%>			
			<% 	if(paging.getEndPage() != paging.getLastPage()){
			%>
				<a href="list.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&gt;</a>	
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