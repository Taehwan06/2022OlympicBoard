<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pass = request.getParameter("pass");	
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String birth1 = request.getParameter("birth1");
	String birth2 = request.getParameter("birth2");
	String birth3 = request.getParameter("birth3");
	String phone = phone1+"-"+phone2+"-"+phone3;
	String birth = birth1+"년 "+birth2+"월 "+birth3+"일";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();		
		String sql ="select * from member where memberid=?";		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,id);		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			response.sendRedirect("join.jsp?idcheck=1");
		}
		
		sql = "insert into member(midx,memberid,memberpassword,membername,birth,phone,email) "
			+ " values(midx_seq.nextval,?,?,?,?,?,?)";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,id);
		psmt.setString(2,pass);
		psmt.setString(3,name);
		psmt.setString(4,birth);
		psmt.setString(5,phone);
		psmt.setString(6,email);
		
		int result = psmt.executeUpdate();
		
		if(result>0){
			response.sendRedirect("login.jsp?joinCheck=1");
		}else{
			response.sendRedirect("login.jsp?joinCheck=2");
		}		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>