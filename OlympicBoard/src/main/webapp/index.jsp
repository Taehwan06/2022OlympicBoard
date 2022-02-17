<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="OlympicBoard.vo.*"%>
<%@ page import="OlympicBoard.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	ReUrl reurl = new ReUrl();
	String url = request.getRequestURL().toString();
	reurl.setUrl(url);
	session.setAttribute("ReUrl",reurl);

	String withdraw = "";

	Check check = (Check)session.getAttribute("check");
	if(check != null){		
		withdraw = check.getWithdraw();
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2022 베이징 올림픽</title>
<link href="<%=request.getContextPath() %>/css/header.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/nav.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/index.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/css/footer.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<style>

</style>
<script>
	<%	if(withdraw == null){
	%>	
	<%	}else if(withdraw.equals("success")){
	%>		alert("회원 탈퇴가 완료되었습니다.");
	<%	}
	%>
</script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<%@ include file="nav.jsp" %>
	<section>
		<div id="topButtonDiv">
			<img alt="화면 상단으로 이동하는 버튼입니다." src="<%=request.getContextPath() %>/upload/top.png"
			id="topButton" onclick="location.href='#top'">
		</div>
		<div class="news" id="news1" onclick="location.href='https://www.yna.co.kr/view/AKR20220216173651007?input=1195m'">
			<img src="<%=request.getContextPath() %>/upload/news002.jpg">
			-쇼트트랙- 남자 쇼트트랙 대표팀, 계주 5,000ｍ 준우승…12년 만에 메달(종합)
		</div>
		<div class="news" id="news2" onclick="location.href='https://www.mk.co.kr/news/sports/view/2022/02/149569/'">
			<img src="<%=request.getContextPath() %>/upload/news003.jpg">
			-쇼트트랙- 황대헌·곽윤기·박장혁·이준서 쇼트트랙 남자 5000m 계주 은메달
		</div>
		<div class="news" id="news3" onclick="location.href='https://news.jtbc.joins.com/article/article.aspx?news_id=NB12046621'">
			<img src="<%=request.getContextPath() %>/upload/news004.jpg">
			-스피드스케이팅- 피차민규 스피드스케이팅 500m서 2위…평창 이어 2회 연속 은메달
		</div>
		<div class="video" id="video1">
			<iframe width="560" height="315" src="https://www.youtube.com/embed/URrmR9sB2sY?start=327" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
		<div class="video" id="video2">
			<iframe width="560" height="315" src="https://www.youtube.com/embed/guLN9C_5R7Q?start=161" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
		<div class="news" id="news4" onclick="location.href='https://www.yna.co.kr/view/AKR20220217035800007?input=1195m'">
			<img src="<%=request.getContextPath() %>/upload/news005.jpg">
			-컬링- 17일 운명의 스웨덴전 앞둔 컬링 '팀 킴', 4강 진출 경우의 수는?
		</div>
		<div class="news" id="news5" onclick="location.href='https://www.yna.co.kr/view/AKR20220216162700007?input=1195m'">
			<img src="<%=request.getContextPath() %>/upload/news006.jpg">
			-스피드스케이팅- 빙속 차민규·김민석, 18일 1,000ｍ서 나란히 두 번째 메달 사냥
		</div>
		<div class="news" id="news6" onclick="location.href='https://www.yna.co.kr/view/AKR20220217001100007?input=1195m'">
			<img src="<%=request.getContextPath() %>/upload/news007.jpg">
			-쇼트트랙- BTS 슈가도 김연경도 축하…다 함께 기뻐한 최민정의 금메달
		</div>
	</section>
	<%@ include file="footer.jsp" %>
</body>
</html>
<%
	session.setAttribute("check",null);
%>