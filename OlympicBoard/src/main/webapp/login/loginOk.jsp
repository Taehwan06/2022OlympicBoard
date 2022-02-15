<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.json.simple.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	ReUrl reurl = (ReUrl)session.getAttribute("ReUrl");

	String memberid = request.getParameter("memberid2");
	String memberpassword = request.getParameter("memberpassword2");
	String bidx = request.getParameter("bidx");
	String nowPage = request.getParameter("nowPage");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	ListPageData listPageData = (ListPageData)session.getAttribute("listPageData");
	if(listPageData != null){
		searchType = listPageData.getSearchType();
		searchValue = listPageData.getSearchValue();
	}
		
	if(searchValue != null){
		try {
			searchValue = URLEncoder.encode(searchValue, "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "select * from member where memberid=? and memberpassword=? and delyn='N'";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,memberid);
		psmt.setString(2,memberpassword);
		
		rs = psmt.executeQuery();
		
		Member m = null;
		Check check = new Check();
		
		if(rs.next()){
			m = new Member();
			m.setMemberid(rs.getString("memberid"));
			m.setMemberpassword(rs.getString("memberpassword"));
			m.setMembername(rs.getString("membername"));
			m.setPhone(rs.getString("phone"));
			m.setEmail(rs.getString("email"));
			m.setBirth(rs.getString("birth"));
			m.setEnterdate(rs.getString("enterdate"));
			m.setMidx(rs.getInt("midx"));
			m.setUplist(rs.getString("uplist"));
			m.setOriginEnterdate(rs.getString("enterdate"));
			m.setGrade(rs.getString("grade"));
			
			session.setAttribute("loginUser",m);
			check.setLoginCheck("ok");
			check.setLoginCheckFlag(true);
			session.setAttribute("check",check);
			
		}
		
		if(m != null){
			if(reurl != null){
				
				String url = reurl.getUrl();
				url += "?bidx="+bidx;
				url += "&nowPage="+nowPage;
				url += "&searchType="+searchType;
		        url += "&searchValue="+searchValue;
				response.sendRedirect(url);
			}else{
				response.sendRedirect(request.getContextPath());
			}
		}else{
			sql = "select * from member where memberid=? and delyn='N'";
			
			psmt = null;
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,memberid);
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				check.setLoginCheck("pass");
				check.setLoginCheckFlag(true);
				session.setAttribute("check",check);
				response.sendRedirect("login.jsp?memberid="+memberid+"&nowPage="+nowPage+"&searchType="+searchType+"&searchValue="+searchValue);
			}else{
				check.setLoginCheck("all");
				check.setLoginCheckFlag(true);
				session.setAttribute("check",check);
				response.sendRedirect("login.jsp?nowPage="+nowPage+"&searchType="+searchType+"&searchValue="+searchValue);
			}			
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>