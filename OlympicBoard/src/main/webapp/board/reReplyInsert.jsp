<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String bidx = request.getParameter("bidx");
	String reInput = request.getParameter("reReInput");
	String parentridx = request.getParameter("parentridx");
	int lvl = 0;
	int depth = 0;
	int originridx = 0;
	int nextdepth = 0;
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();	
		
		String sql = "";
		
		sql = "select * from reply where ridx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,parentridx);		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			lvl = rs.getInt("lvl");
			depth = rs.getInt("depth");
			originridx = rs.getInt("originridx");
		}
		
		sql = "select min(depth) from reply where originridx=? and lvl=? and depth>?";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,originridx);
		psmt.setInt(2,lvl);
		psmt.setInt(3,depth);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			if(rs.getInt("min(depth)") == 0){
				nextdepth = 1;
			}else{
				nextdepth = rs.getInt("min(depth)")+1;
			}
		}
		
		sql = "update reply set depth=depth+1 where originridx=? and depth >= ?";
		psmt = conn.prepareStatement(sql);
		psmt.setInt(1,originridx);
		psmt.setInt(2,nextdepth);
		
		sql = "insert into reply(ridx,rcontent,rwriter,bidx,midx,originridx,lvl,depth) values(ridx_seq.nextval,?,?,?,?,?,?,?)";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,reInput);
		psmt.setString(2,loginUser.getMembername());
		psmt.setString(3,bidx);
		psmt.setInt(4,loginUser.getMidx());
		psmt.setInt(5,originridx);
		psmt.setInt(6,(lvl+1));
		psmt.setInt(7,(nextdepth));
		
		psmt.executeUpdate();
		
		sql = "update board set recnt=((select recnt from board where bidx=?)+1) where bidx=?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,bidx);
		psmt.setString(2,bidx);
		psmt.executeUpdate();
		
		sql = "select * from reply where ridx = "
				+"(select max(ridx) from reply)";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		Reply reply = new Reply();
		
		JSONArray list = new JSONArray();
		if(rs.next()){
			JSONObject jobj = new JSONObject();
			jobj.put("rwriter",rs.getString("rwriter"));
			jobj.put("rcontent",rs.getString("rcontent"));
			jobj.put("ridx",rs.getInt("ridx"));
			jobj.put("lvl",rs.getInt("lvl"));
			
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