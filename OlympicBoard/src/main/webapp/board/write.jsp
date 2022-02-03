<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>
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
			<table border=1>		
				<tbody>
					<tr>
						<td>제목</td>
						<td><input></td>
					<tr>
					<tr>
						<td>작성자</td>
						<td><%=rs.getString("bwriter") %></td>
					<tr>
					<tr>
						<td>작성일</td>
						<td><%=rs.getString("bwdate") %></td>
					<tr>
					<tr>
						<td>조회수</td>
						<td><%=rs.getString("bhit") %></td>
					<tr>
					<tr>	
						<td colspan="2"><%=rs.getString("bcontent") %></td>
					<tr>
					<tr>
						<td colspan="2">추천</td>
					<tr>
				</tbody>
			</table>
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>