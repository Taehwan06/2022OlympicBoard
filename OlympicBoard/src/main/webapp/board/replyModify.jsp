<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String rcontent = request.getParameter("reModifyInsert");
	String ridx = request.getParameter("ridx");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "update reply set rcontent=?, rmdate=sysdate where ridx=?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,rcontent);
		psmt.setString(2,ridx);
		
		psmt.executeUpdate();
		
		sql = "select * from reply where ridx=?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,ridx);
		
		rs = psmt.executeQuery();
		
		JSONArray list = new JSONArray();
		if(rs.next()){
			JSONObject jobj = new JSONObject();
			jobj.put("rcontent",rs.getString("rcontent"));
			
			list.add(jobj);
		}
		
		out.print(list.toJSONString());
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn);
	}
%>