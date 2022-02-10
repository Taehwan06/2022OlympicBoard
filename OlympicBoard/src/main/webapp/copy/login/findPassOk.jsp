<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%@ page import= "java.security.SecureRandom"%>
<%@ page import= "java.util.Date"%>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String phone = phone1+"-"+phone2+"-"+phone3;	
	String email = request.getParameter("email");	
		
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	Connection conn2 = null;
	PreparedStatement psmt2 = null;
	
	Check check = new Check();
	
	try{
		conn = DBManager.getConnection();
		String sql = "select * from member where membername=? and memberid=? and phone=? and email=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,name);
		psmt.setString(2,id);
		psmt.setString(3,phone);
		psmt.setString(4,email);
		
		rs = psmt.executeQuery();		
		
		if(rs.next()){
			RandomPassword rp = new RandomPassword();
			String pass = rp.getRamdomPassword(10);
			
			try{				
				conn2 = DBManager.getConnection();
				String sql2 = "update member set memberpassword=? where midx=?";				
				psmt2 = conn2.prepareStatement(sql2);
				psmt2.setString(1,pass);
				psmt2.setInt(2,rs.getInt("midx"));
				
				int result = psmt2.executeUpdate();
				
				if(result>0){
					MailSend.pass(email,pass);
					response.sendRedirect("findPassSuccess.jsp");
				}
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				DBManager.close(psmt,conn);
			}
			
		}else{
			check.setPassCheck(true);
			session.setAttribute("check",check);
			response.sendRedirect("findPass.jsp");
		}		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}	
%>