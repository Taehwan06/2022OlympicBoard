<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	ReUrl reurl = (ReUrl)session.getAttribute("ReUrl");	

	String memberid = request.getParameter("memberid");
	String memberpassword = request.getParameter("memberpassword");
	String bidx = request.getParameter("bidx");
	String nowPage = request.getParameter("nowPage");
	
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
			
			session.setAttribute("loginUser",m);
			check.setLoginCheck("ok");
			session.setAttribute("check",check);
		}
		
		if(m != null){
			if(reurl != null){
				String url = reurl.getUrl()+"?bidx="+bidx+"&nowPage="+nowPage;
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
				session.setAttribute("check",check);
				response.sendRedirect("login.jsp?memberid="+memberid+"&nowPage="+nowPage);
			}else{
				check.setLoginCheck("all");
				session.setAttribute("check",check);
				response.sendRedirect("login.jsp?nowPage="+nowPage);
			}			
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>