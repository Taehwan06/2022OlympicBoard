<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="OlympicBoard.vo.*" %>
<%@ page import="OlympicBoard.util.*" %>
<%
	int cnt = 0;

	Member loginUser = (Member)session.getAttribute("loginUser");
	if(loginUser == null){
		response.sendRedirect(request.getContextPath());
	}else{
		int midx = loginUser.getMidx();

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			conn = DBManager.getConnection();
			
			String sql = "select * from (select count(*) c from board where midx=?)";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,midx);
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				cnt = rs.getInt("c");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(psmt,conn,rs);
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>

<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<style>	
	*{
		margin:0px;
		padding:0px;
	}
	body{
		width: 800px;
		height: 90vh;
		min-height: 500px;
		margin: auto;
	}
	header{
		height:70px;			
		text-align:center;
		position:relative;
	}
	header>div{
		text-align:right;
		position:absolute;
		top:20px;
		right:20px;
	}
	header>div>span{
		padding-right: 10px;
	}
	header>div>input{
		height: 22px;
		width: 90px;
		border-radius: 5px;
		border: 1px solid gray;
		background: lightgray;
	}
	header>div input:hover{
		cursor: pointer;
		background-color: skyblue;
		border-radius: 5px;
	}
	header>h2{
		padding:20px;
	}
	header>h2>a{
		text-decoration: none;
		color: black;
	}
	header>h2>a:hover{
		color: skyblue;
	}
	nav{
		height: 30px;
		width: 800px;
		background: #EEEEEE;			
		text-align: center;
	}		
	nav span{
		background: #EEEEEE;	
		color: black;
		height: 27px;
		width: 100px;
		padding-top: 3px;			
		display: inline-block;			
		text-align: center;
	}
	nav span:hover{
		background: gray;
		color: skyblue;
		cursor: pointer;
	}
	section{
		height:70%;
		text-align: center;
		padding: 50px 0px;
		margin: auto;
	}
	.border{
		width: 450px;
		border: 1px solid lightgray;
		display: inline-block;
		border-radius: 5px;
		margin: 10px;
	}
	.border span{
		content-size: 15px;
		height: 20px;
		padding: 5px 0px 8px;
		display: inline-block;
	}
	.left{
		width: 170px;
		border-right: 1px solid lightgray;
	}
	.right{
		width: 260px;
	}
	.button{
		margin: 50px 0px;
	}
	.button .border{
		width: 250px;
	}
	.button .border:hover{
		background: skyblue;
		cursor: pointer;
	}
	footer{
		height:50px;
		border-top:1px solid gray;
		text-align: center;
	}
	footer div{
		margin: 15px;
	}
</style>
<script>

</script>
</head>
<body>
	<%@ include file="/loginHeader.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div>		
			<div>
				<div class="border">
					<span class="left">아이디</span>
					<span class="right"><%=loginUser.getMemberid() %></span>
				</div>
				<div class="border">
					<span class="left">성명</span>
					<span class="right"><%=loginUser.getMembername() %></span>
				</div>
				<div class="border">
					<span class="left">연락처</span>
					<span class="right"><%=loginUser.getPhone() %></span>
				</div>
				<div class="border">
					<span class="left">이메일 주소</span>
					<span class="right"><%=loginUser.getEmail() %></span>
				</div>
				<div class="border">
					<span class="left">가입일</span>
					<span class="right"><%=loginUser.getEnterdate() %></span>
				</div>
				<div class="border">
					<span class="left">작성한 게시글 수</span>
					<span class="right"><%=cnt %></span>
				</div>
			</div>
			<div class="button">
				<div class="border" onclick="mylistFn()">
					<span>내가 쓴 글 보러가기</span>
				</div><br>
				<div class="border" onclick="modifyFn()()">
					<span>회원정보 수정</span>
				</div><br>
				<div class="border" onclick="withdrawFn()">
					<span>회원 탈퇴</span>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	}
	session.setAttribute("check",null);
%>