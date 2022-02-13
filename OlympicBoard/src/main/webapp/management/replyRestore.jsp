<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String ridx = request.getParameter("ridx");
	String bidx = request.getParameter("bidx");
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "";
		
		sql = "update reply set rdelyn='N' where ridx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,ridx);
		
		psmt.executeUpdate();
		
		sql = "select * from reply where ridx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,ridx);
				
		rs = psmt.executeQuery();
		
		Reply reply = new Reply();
		
		JSONArray list = new JSONArray();
		if(rs.next()){
			JSONObject jobj = new JSONObject();
			jobj.put("rwriter",rs.getString("rwriter"));
			jobj.put("rcontent",rs.getString("rcontent"));
			jobj.put("ridx",rs.getInt("ridx"));
			
			reply.setRwdate(rs.getString("rwdate"));
			jobj.put("rwdate",reply.getRwdate());
			
			list.add(jobj);
		}
		
		out.print(list.toJSONString());
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>