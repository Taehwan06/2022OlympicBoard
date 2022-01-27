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
	document.loginFrm.action = "loginOk.jsp";
	document.loginFrm.submit();
}
function findIdFn(){
	location.href="join.jsp";
}
function findPassFn(){
	location.href="join.jsp";
}
function joinFn(){
	location.href="join.jsp";
}