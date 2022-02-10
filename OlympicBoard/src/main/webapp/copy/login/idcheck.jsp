<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String value = request.getParameter("value");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
		
	try{
		conn = DBManager.getConnection();
		
		String sql = "select * from member where memberid='"+value+"'";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		JSONArray list = new JSONArray();
		
		if(rs.next()){
			JSONObject jobj = new JSONObject();
			
			jobj.put("memberid",rs.getString("memberid"));
			jobj.put("membername",rs.getString("membername"));
			jobj.put("midx",rs.getInt("midx"));
			
			list.add(jobj);
		}
		
		out.print(list.toJSONString());
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}	
%>