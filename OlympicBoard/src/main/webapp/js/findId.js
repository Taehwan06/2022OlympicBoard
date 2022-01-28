function findIdFn(){
	document.findIdFrm.method = "post";
	document.findIdFrm.action = "findIdOk.jsp";
	document.findIdFrm.submit();
}
function loginFn(){
	location.href="login.jsp";
}	
function findPassFn(){
	location.href="findPass.jsp";
}
function joinFn(){
	location.href="join.jsp";
}