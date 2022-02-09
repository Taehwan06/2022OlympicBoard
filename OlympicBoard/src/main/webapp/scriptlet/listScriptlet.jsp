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
		
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	Notice notice = new Notice();
	
	String nowPage = request.getParameter("nowPage");
	int nowPageI = 1;
	if(nowPage != null && !nowPage.equals("") && !nowPage.equals("null")){
		nowPageI = Integer.parseInt(nowPage);
	}
		
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	PagingUtil paging = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "select count(*) as total from board where bdelyn='N' ";
		
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
		sql += "(SELECT * FROM board where bdelyn='N' "; 
		
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