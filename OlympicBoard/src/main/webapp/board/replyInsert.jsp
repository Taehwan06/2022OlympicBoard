<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String bidx = request.getParameter("bidx");
	String reInput = request.getParameter("reInput");
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();	
		
		String sql = "insert into reply(ridx,rcontent,rwriter,bidx,midx) values(ridx_seq.nextval,?,?,?,?)";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,reInput);
		psmt.setString(2,loginUser.getMembername());
		psmt.setString(3,bidx);
		psmt.setInt(4,loginUser.getMidx());
		
		int result = psmt.executeUpdate();
		
		sql = "select * from reply where ridx = "
				+"(select max(ridx) from reply)";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		Notice notice = new Notice();
		
		JSONArray list = new JSONArray();
		if(rs.next()){
			JSONObject jobj = new JSONObject();
			jobj.put("rwriter",rs.getString("rwriter"));
			jobj.put("rcontent",rs.getString("rcontent"));
			
			notice.setReplyWritedate(rs.getString("rwdate"));
			jobj.put("rwdate",notice.getReplyWritedate());			
			
			list.add(jobj);
		}
		
		out.print(list.toJSONString());
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
%>