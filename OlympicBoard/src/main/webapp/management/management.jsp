<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%	
	request.setCharacterEncoding("UTF-8");

	String memberModify = "";
	String withdraw = "";
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	String nowPage = request.getParameter("nowPage");
	
	Check check = (Check)session.getAttribute("check");
	if(check != null){
		if(check.getMemberModify() != null){
			memberModify = check.getMemberModify();
		}
		if(check.getWithdraw() != null){
			withdraw = check.getWithdraw();
		}
	}
	
	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}else{
		if(!loginUser.getGrade().equals("A")){
			response.sendRedirect(request.getContextPath());
		}
		
		Notice notice = new Notice();
		
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
			
			String sql = "select count(*) as total from member ";
			
			if(searchValue != null && !searchValue.equals("")){
				if(searchType.equals("memberid")){
					sql += " where memberid like '%"+searchValue+"%' ";
				}else if(searchType.equals("membername")){
					sql += " where membername like '%"+searchValue+"%' ";
				}else if(searchType.equals("memberidx")){
					sql += " where midx = '"+searchValue+"' ";
				}else if(searchType.equals("phone")){
					sql += " where phone like '%"+searchValue+"%' ";
				}else if(searchType.equals("email")){
					sql += " where email like '%"+searchValue+"%' ";
				}
			}
			
			psmt = conn.prepareStatement(sql);
			
			rs = psmt.executeQuery();
			
			int total = 0;
			
			if(rs.next()){
				total = rs.getInt("total");
			}
			
			paging = new PagingUtil(total,nowPageI,10);
			
			sql = " select * from ";
			sql += " (select rownum r , m.* from ";
			sql += "(SELECT * FROM member ";
			
			if(searchValue != null && !searchValue.equals("")){
				if(searchType.equals("memberid")){
					sql += " where memberid like '%"+searchValue+"%' ";
				}else if(searchType.equals("membername")){
					sql += " where membername like '%"+searchValue+"%' ";
				}else if(searchType.equals("memberidx")){
					sql += " where midx = '"+searchValue+"' ";
				}else if(searchType.equals("phone")){
					sql += " where phone like '%"+searchValue+"%' ";
				}else if(searchType.equals("email")){
					sql += " where email like '%"+searchValue+"%' ";
				}			
			}
			
			sql += " order by midx ) m) ";
			sql += " where r>="+paging.getStart()+" and r<="+paging.getEnd();
			
			psmt = conn.prepareStatement(sql);
			
			rs = psmt.executeQuery();				
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/management.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	function memberViewFn(midx){
		location.href = "memberView.jsp?nowPage=<%=paging.getNowPage() %>&midx="+midx+"&searchType=<%=searchType %>&searchValue=<%=searchValue %>"
	}
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div>
			<form name="searchFrm" action="management.jsp">
				<select name="searchType">
					<option value="memberid"
					<%if(searchType != null && !searchType.equals("") && searchType.equals("memberid")) 
						out.print("selected"); %>>아이디</option>
					<option value="membername"
					<%if(searchType != null && !searchType.equals("") && searchType.equals("membername")) 
						out.print("selected"); %>>성명</option>
					<option value="memberidx"
					<%if(searchType != null && !searchType.equals("") && searchType.equals("memberidx")) 
						out.print("selected"); %>>회원번호</option>
					<option value="phone"
					<%if(searchType != null && !searchType.equals("") && searchType.equals("phone")) 
						out.print("selected"); %>>연락처</option>
						<option value="email"
					<%if(searchType != null && !searchType.equals("") && searchType.equals("email")) 
						out.print("selected"); %>>이메일</option>
				</select>
				<div>
					<input type="text" name="searchValue" size="20"
					<%if(searchValue != null && !searchValue.equals("") && 
					!searchValue.equals("null")) out.print("value='"+searchValue+"'"); %>>
					<input type="submit" name="searchSubmit" value="검색">
				</div>
			</form>
			<div id="box">
				<div id="titleRow">
					<span class="midxSpan">회원번호</span>
					<span class="idSpan">아이디</span>
					<span class="nameSpan">성명</span>
					<span class="edateSpan">가입일</span>	
					<span class="gradeSpan">회원 등급</span>
					<span class="delSpan">탈퇴</span>
				</div>
		<%	while(rs.next()){
				notice.setMemberEnterdate(rs.getString("enterdate"));
		%>		<div class="rowDiv" onclick="memberViewFn(<%=rs.getInt("midx") %>)">
					<span class="midxSpan"><%=rs.getInt("midx") %></span>
					<span class="idSpan"><%=rs.getString("memberid") %></span>
					<span class="nameSpan"><%=rs.getString("membername") %></span>
					<span class="edateSpan"><%=notice.getMemberEnterdate() %></span>
					<span class="gradeSpan"><%=rs.getString("grade") %></span>
					<span class="delSpan"><%=rs.getString("delyn") %></span>
				</div>
		<%	}
		%>	
			</div>
			<div id="pagingArea">
			<% 	if(paging.getStartPage() > 1){
			%>		<input type="button" class="backButton" value="이전" 
					onclick="location.href='management.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
			<%	}
				for(int i= paging.getStartPage(); i<=paging.getEndPage(); i++){
					if(i == paging.getNowPage()){
			%>			<input type="button" class="selButton" value="<%=i%>" 
						onclick="location.href='management.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
			<%		}else{
			%>			<input type="button" class="numButton" value="<%=i%>" 
						onclick="location.href='management.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
			<%		}
				}						
			 	if(paging.getEndPage() != paging.getLastPage()){
			%>		<input type="button" class="nextButton" value="다음" 
					onclick="location.href='management.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">
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