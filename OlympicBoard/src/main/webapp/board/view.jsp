<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String bidx = request.getParameter("bidx");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	Cookie[] cookieHCA = request.getCookies();

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
	
	Member loginUser = (Member)session.getAttribute("loginUser");

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
%>
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
						<td><%=rs.getString("bsubject") %></td>
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
			<div id="buttonDiv">
		<%	if(loginUser != null && loginUser.getMidx() == rs.getInt("midx")){ 
		%>		<input type="button" id="modifyButton" value="수정" onclick="modifyFn()">
				<input type="button" id="deleteButton" value="삭제" onclick="deleteFn()">
		<%	}
		%>		<input type="button" id="listButton" value="목록" onclick="listFn()">
			</div>
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>