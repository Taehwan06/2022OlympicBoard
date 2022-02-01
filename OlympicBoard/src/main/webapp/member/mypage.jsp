<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="OlympicBoard.vo.*" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
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
	section>div{
		width: 600px;
		height: 300px;
		background: lightskyblue;
		text-align: center;
		font-size: 25px;
		font-weight: bold;
		padding-top: 100px;
		display: inline-block;
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
			</div>
			<div>
				<div class="border">
					<span class="left">가입일</span>
					<span class="right"><%=loginUser.getEnterdate() %></span>
				</div>
			</div>
			
			
			
			
		</div>
		
		
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	session.setAttribute("check",null);
%>