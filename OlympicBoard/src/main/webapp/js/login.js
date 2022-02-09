function onBlurFn(obj){
	var value = obj.value;
	var span = obj.parentElement.parentElement.getElementsByTagName("span")[1];
	var id = obj.id;
	
	if(value == ""){
		span.style.visibility = "visible";
	}else{
		span.style.visibility = "hidden";
	}
}
function loginFn(){
	document.loginFrm.method = "post";
	document.loginFrm.action = "loginOk.jsp?nowPage="+nowPage;
	document.loginFrm.submit();
}
function findIdFn(){
	location.href="findId.jsp";
}
function findPassFn(){
	location.href="findPass.jsp";
}
function joinFn(){
	location.href="join.jsp";
}