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
	
	ReUrl reurl = new ReUrl();
	String url = request.getContextPath();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);
	
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
	
	ArrayList<Board> boardNoticeA = new ArrayList<>();
	
	PagingUtil paging = null;
	
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
				String sql = "";
				
				sql = "select * from board where bnotice='Y' order by bidx desc";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				while(rs.next()){
					Board boardNotice = new Board();
					boardNotice.setBcontent(rs.getString("bcontent"));
					boardNotice.setBdelyn(rs.getString("bdelyn"));
					boardNotice.setBhit(rs.getInt("bhit"));
					boardNotice.setBidx(rs.getInt("bidx"));
					boardNotice.setBimgori(rs.getString("bimgori"));
					boardNotice.setBimgori2(rs.getString("bimgori2"));
					boardNotice.setBimgori3(rs.getString("bimgori3"));
					boardNotice.setBimgsys(rs.getString("bimgsys"));
					boardNotice.setBimgsys2(rs.getString("bimgsys2"));
					boardNotice.setBimgsys3(rs.getString("bimgsys3"));
					boardNotice.setBnotice(rs.getString("bnotice"));
					boardNotice.setBsubject(rs.getString("bsubject"));
					boardNotice.setBwdate(rs.getString("bwdate"));
					boardNotice.setBwriter(rs.getString("bwriter"));
					boardNotice.setMidx(rs.getInt("midx"));
					boardNotice.setRecnt(rs.getInt("recnt"));
					boardNotice.setUp(rs.getInt("up"));
					boardNotice.setOriginWdate(rs.getString("bwdate"));
					boardNotice.setBmdate(rs.getString("bmdate"));
					
					boardNoticeA.add(boardNotice);
				}
				
				
				
				sql = "select count(*) as total from board ";
				sql += " where bnotice='N' ";
				
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
				
				rs = psmt.executeQuery();
				
				int total = 0;
				
				if(rs.next()){
					total = rs.getInt("total");
				}
				
				paging = new PagingUtil(total,nowPageI,10);
				
				sql = " select * from ";
				sql += " (select rownum r , b.* from ";		
				sql += "(SELECT * FROM board "; 
				sql += " where bnotice='N' ";
				
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
				
				rs = psmt.executeQuery();	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 관리</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/manageBoard.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	function viewFn(bidx){
		location.href="manageBoardView.jsp?bidx="+bidx+"&nowPage=<%=paging.getNowPage() %>&searchType=<%=searchType %>&searchValue=<%=searchValue %>";
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
			<form name="searchFrm" action="manageBoard.jsp">
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
			<div id="box">
				<div id="titleRow">
					<span class="bidxSpan">글번호</span>
					<span class="subjectSpan">제목</span>
					<span class="writerSpan">작성자</span>					
					<span class="wdateSpan">작성일</span>
					<span class="hitSpan">조회수</span>
					<span class="upSpan">추천</span>
					<span class="delSpan">삭제</span>
				</div>
				
		<%	for(Board bn : boardNoticeA){
				notice.setListWritedate(bn.getOriginWdate());
		%>		<div class="rowDiv" onclick="viewFn(<%=bn.getBidx() %>)" 
		<%		if(bn.getBdelyn().equals("Y")){ out.print("style='color:gray'"); } %>>
					<span class="bidxSpan"><%=bn.getBidx() %></span>
					<span class="subjectSpan" <% if(bn.getBnotice().equals("Y")){ out.print("style='color:red'"); } %>>
						<%	if(bn.getBnotice().equals("Y")){ out.print("<b>[공지] "); } %>
						<%=bn.getBsubject() %> 
						<%	if(bn.getRecnt()>0){ 
						%>		[<%=bn.getRecnt() %>]
						<%	} 
						%>
						<%	if(bn.getBnotice().equals("Y")){ out.print("</b>"); } %>
					</span>
					<span class="writerSpan"><%=bn.getBwriter() %></span>
					<span class="wdateSpan"><%=notice.getListWritedate() %></span>
					<span class="hitSpan"><%=bn.getBhit() %></span>
					<span class="upSpan"><%=bn.getUp() %></span>
					<span class="delSpan"><%=bn.getBdelyn() %></span>
				</div>
		<%	}
		%>		
				
		<%	while(rs.next()){
				notice.setListWritedate(rs.getString("bwdate"));
		%>		<div class="rowDiv" onclick="viewFn(<%=rs.getInt("bidx") %>)" 
				<% if(rs.getString("bdelyn").equals("Y")){ out.print("style='color:gray'"); } %>>
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
				%>
					</span>
					<span class="hitSpan"><%=rs.getInt("bhit") %></span>
					<span class="upSpan"><%=rs.getInt("up") %></span>
					<span class="delSpan"><%=rs.getString("bdelyn") %></span>
				</div>
		<%	}
		%>	</div>
			
			<div id="pagingArea">
			<% 	if(paging.getStartPage() > 1){	
			%>		<input type="button" class="backButton" value="이전" 
					onclick="location.href='manageBoard.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>#pagingArea'">
			<%	}
				for(int i= paging.getStartPage(); i<=paging.getEndPage(); i++){
					if(i == paging.getNowPage()){
			%>			<input type="button" class="selButton" value="<%=i%>" 
						onclick="location.href='manageBoard.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>#pagingArea'">
			<%		}else{
			%>			<input type="button" class="numButton" value="<%=i%>" 
						onclick="location.href='manageBoard.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>#pagingArea'">
			<%		}
				}
			 	if(paging.getEndPage() != paging.getLastPage()){
			%>		<input type="button" class="nextButton" value="다음" 
					onclick="location.href='manageBoard.jsp?nowPage=<%=paging.getEndPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>#pagingArea'">
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
	}
	
	session.setAttribute("check",null);
%>