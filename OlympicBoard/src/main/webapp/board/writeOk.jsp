<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String notice = request.getParameter("notice");
	String bimgsys = null;
	String bimgori = null;
	String bimgsys2 = null;
	String bimgori2 = null;
	String bimgsys3 = null;
	String bimgori3 = null;
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}
	
	Board board1 = (Board)session.getAttribute("board1");
	Board board2 = (Board)session.getAttribute("board2");
	Board board3 = (Board)session.getAttribute("board3");
	if(board1 != null){
		bimgsys = board1.getBimgsys();
		bimgori = board1.getBimgori();
	}
	if(board2 != null){
		bimgsys2 = board2.getBimgsys2();
		bimgori2 = board2.getBimgori2();
	}
	if(board3 != null){
		bimgsys3 = board3.getBimgsys3();
		bimgori3 = board3.getBimgori3();
	}
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		String sql = "";
		
		sql += "insert into board(bidx,bsubject,bcontent,bwriter,midx";
		
		if(notice != null && (notice.equals("N") || notice.equals("Y"))){
			sql += ",bnotice";
		}
		if(bimgsys != null && bimgori != null){
			sql += ",bimgsys,bimgori";
		}
		if(bimgsys2 != null && bimgori2 != null){
			sql += ",bimgsys2,bimgori2";
		}
		if(bimgsys3 != null && bimgori3 != null){
			sql += ",bimgsys3,bimgori3";
		}
		
		sql	+= ") values(bidx_seq.nextval,?,?,?,?";
		
		if(notice != null && (notice.equals("N") || notice.equals("Y"))){
			sql += ",'"+notice+"'";
		}
		if(bimgsys != null && bimgori != null){
			sql += ",'"+bimgsys+"','"+bimgori+"'";
		}
		if(bimgsys2 != null && bimgori2 != null){
			sql += ",'"+bimgsys2+"','"+bimgori2+"'";
		}
		if(bimgsys3 != null && bimgori3 != null){
			sql += ",'"+bimgsys3+"','"+bimgori3+"'";
		}
		
		sql += ")";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,subject);
		psmt.setString(2,content);
		psmt.setString(3,loginUser.getMembername());
		psmt.setInt(4,loginUser.getMidx());
		
		int result = psmt.executeUpdate();
		
		Check check = new Check();
		if(result>0){
			check.setWriteCheck(true);
			session.setAttribute("check",check);
		}
		response.sendRedirect(request.getContextPath()+"/board/list.jsp");
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}
%>