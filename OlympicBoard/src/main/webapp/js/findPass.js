var ph1Reg = /\d{2,3}/;
var ph2Reg = /\d{3,4}/;
var ph3Reg = /\d{4}/;

function onBlurFn(obj){
	var value = obj.value;
	var span = obj.parentElement.parentElement.getElementsByTagName("span")[1];
	var id = obj.id;
	var reg = "";
	var ph1Val = document.getElementById("phone1").value;
	var ph2Val = document.getElementById("phone2").value;
	var ph3Val = document.getElementById("phone3").value;

	if(id =="id"){
		reg = /^[a-z]+[a-z0-9]{5,19}$/g;
		if(value == ""){
			span.style.visibility = "visible";
			span.textContent = "아이디를 입력하세요";
			span.style.color = "red";
			result = false;
		}else if(!reg.test(value)){
			span.style.visibility = "visible";
			span.textContent = "아이디를 올바르게 입력하세요";
			span.style.color = "red";
			result = false;
		}else{
			span.style.visibility = "hidden";
			span.textContent = "";
		}
	
	}else if(id =="name"){
		reg = /[가-힣]{2,20}$/;
		if(value == ""){
			span.style.visibility = "visible";
			span.textContent = "이름을 입력하세요";
			span.style.color = "red";
		}else if(!reg.test(value)){
			span.style.visibility = "visible";
			span.textContent = "2~20자 한글만 입력 가능합니다";
			span.style.color = "red";
		}else{
			span.style.visibility = "visible";
			span.textContent = "";
			span.style.color = "green";
		}
		
	}else if(id =="email"){
		reg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if(value == ""){
			span.style.visibility = "visible";
			span.textContent = "이메일 주소를 입력하세요";
			span.style.color = "red";
		}else if(!reg.test(value)){
			span.style.visibility = "visible";
			span.textContent = "이메일 주소 형식이 올바르지 않습니다";
			span.style.color = "red";
		}else{
			span.style.visibility = "visible";
			span.textContent = "";
			span.style.color = "green";
		}
	}

	if(id =="phone1"){
		if(ph1Reg.test(ph1Val) && ph2Reg.test(ph2Val) && ph3Reg.test(ph3Val)){
			span.style.visibility = "visible";
			span.textContent = "";
			span.style.color = "green";
		}else{
			span.style.visibility = "visible";
			span.textContent = "연락처를 올바르게 입력해주세요";
			span.style.color = "red";
		}
	}
	if(id =="phone2"){
		if(ph1Reg.test(ph1Val) && ph2Reg.test(ph2Val) && ph3Reg.test(ph3Val)){
			span.style.visibility = "visible";
			span.textContent = "";
			span.style.color = "green";
		}else{
			span.style.visibility = "visible";
			span.textContent = "연락처를 올바르게 입력해주세요";
			span.style.color = "red";
		}
	}
	if(id =="phone3"){
		if(ph1Reg.test(ph1Val) && ph2Reg.test(ph2Val) && ph3Reg.test(ph3Val)){
			span.style.visibility = "visible";
			span.textContent = "";
			span.style.color = "green";
		}else{
			span.style.visibility = "visible";
			span.textContent = "연락처를 올바르게 입력해주세요";
			span.style.color = "red";				
		}
	}	
}

function findPassFn(){
	var result = true;
	
	var value = document.getElementById("name").value;
	var span = document.getElementById("nameSpan");
	var reg = reg = /[가-힣]{2,20}$/;
	if(value == ""){
		span.style.visibility = "visible";
		span.textContent = "이름을 입력하세요";
		span.style.color = "red";
		result = false;
	}else if(!reg.test(value)){
		span.style.visibility = "visible";
		span.textContent = "한글만 입력 가능합니다";
		span.style.color = "red";
		result = false;
	}else{
		span.style.visibility = "hidden";
		span.textContent = "";
	}
	
	value = document.getElementById("id").value;
	span = document.getElementById("idSpan");
	reg = /^[a-z]+[a-z0-9]{5,19}$/g;
	
	if(value == ""){
		span.style.visibility = "visible";
		span.textContent = "아이디를 입력하세요";
		span.style.color = "red";
		result = false;
	}else if(!reg.test(value)){
		span.style.visibility = "visible";
		span.textContent = "아이디를 올바르게 입력하세요";
		span.style.color = "red";
		result = false;
	}else{
		span.style.visibility = "hidden";
		span.textContent = "";
	}
	
	span = document.getElementById("phoneSpan");
	var ph1Val = document.getElementById("phone1").value;
	var ph2Val = document.getElementById("phone2").value;
	var ph3Val = document.getElementById("phone3").value;
	if(ph1Reg.test(ph1Val) && ph2Reg.test(ph2Val) && ph3Reg.test(ph3Val)){
		span.style.visibility = "hidden";
		span.textContent = "";
	}else{
		span.style.visibility = "visible";
		span.textContent = "연락처를 올바르게 입력해주세요";
		span.style.color = "red";
		result = false;
	}
	
	value = document.getElementById("email").value;
	span = document.getElementById("emailSpan");
	reg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	if(value == ""){
		span.style.visibility = "visible";
		span.textContent = "이메일 주소를 입력하세요";
		span.style.color = "red";
		result = false;
	}else if(!reg.test(value)){
		span.style.visibility = "visible";
		span.textContent = "이메일 주소 형식이 올바르지 않습니다";
		span.style.color = "red";
		result = false;
	}else{
		span.style.visibility = "hidden";
		span.textContent = "";
	}
	
	if(result){
		document.findPassFrm.method = "post";
		document.findPassFrm.action = "findPassOk.jsp";
		document.findPassFrm.submit();
	}
}

function loginFn(){
	location.href="login.jsp";
}
	
function findIdFn(){
	location.href="findId.jsp";
}

function joinFn(){
	location.href="join.jsp";
}