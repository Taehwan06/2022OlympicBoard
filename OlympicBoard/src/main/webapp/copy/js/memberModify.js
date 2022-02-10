var ph1Reg = /\d{2,3}/;
var ph2Reg = /\d{3,4}/;
var ph3Reg = /\d{4}/;

function onBlurFn(obj){
	var value = obj.value;
	var span = obj.parentElement.parentElement.getElementsByTagName("span")[1];
	var id = obj.id;
	var reg = "";
	var passValue = document.getElementById("pass").value;
	var ph1Val = document.getElementById("phone1").value;
	var ph2Val = document.getElementById("phone2").value;
	var ph3Val = document.getElementById("phone3").value;
	
	if(id =="pass"){			
		reg = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{6,20}$/;
		if(value == ""){
			span.style.visibility = "visible";
			span.textContent = "비밀번호를 입력하세요";
			span.style.color = "red";
		}else if(!reg.test(value)){
			span.style.visibility = "visible";
			span.textContent = "영문, 숫자, 특수문자를 모두 포함한 6~20자리만 가능합니다";
			span.style.color = "red";
		}else{
			span.style.visibility = "visible";
			span.textContent = "사용 가능한 비밀번호입니다";
			span.style.color = "green";
		}
	}else if(id =="passcheck"){	
		if(value == ""){
			span.style.visibility = "visible";
			span.textContent = "비밀번호를 다시 입력하세요";
			span.style.color = "red";
		}else if(value != passValue){
			span.style.visibility = "visible";
			span.textContent = "비밀번호가 다릅니다";
			span.style.color = "red";
		}else{
			span.style.visibility = "visible";
			span.textContent = "비밀번호가 일치합니다";
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
			span.textContent = "올바르게 입력하셨습니다";
			span.style.color = "green";
			obj.style.color = "black";
		}
	}

	if(id =="phone1"){
		if(ph1Reg.test(ph1Val) && ph2Reg.test(ph2Val) && ph3Reg.test(ph3Val)){
			span.style.visibility = "visible";
			span.textContent = "올바르게 입력하셨습니다";
			span.style.color = "green";
			obj.style.color = "black";
		}else{
			span.style.visibility = "visible";
			span.textContent = "연락처를 올바르게 입력해주세요";
			span.style.color = "red";
		}
	}
	if(id =="phone2"){
		if(ph1Reg.test(ph1Val) && ph2Reg.test(ph2Val) && ph3Reg.test(ph3Val)){
			span.style.visibility = "visible";
			span.textContent = "올바르게 입력하셨습니다";
			span.style.color = "green";
			obj.style.color = "black";
		}else{
			span.style.visibility = "visible";
			span.textContent = "연락처를 올바르게 입력해주세요";
			span.style.color = "red";
		}
	}
	if(id =="phone3"){
		if(ph1Reg.test(ph1Val) && ph2Reg.test(ph2Val) && ph3Reg.test(ph3Val)){
			span.style.visibility = "visible";
			span.textContent = "올바르게 입력하셨습니다";
			span.style.color = "green";
			obj.style.color = "black";
		}else{
			span.style.visibility = "visible";
			span.textContent = "연락처를 올바르게 입력해주세요";
			span.style.color = "red";				
		}
	}	
}

function modifySubmitFn(){
	var result = true;
	
	var value = document.getElementById("pass").value;
	var span = document.getElementById("passSpan");
	var reg = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{6,20}$/;
	if(value == ""){
		span.style.visibility = "visible";
		span.textContent = "비밀번호를 입력하세요";
		span.style.color = "red";
		result = false;
	}else if(!reg.test(value)){
		span.style.visibility = "visible";
		span.textContent = "영문, 숫자, 특수문자를 모두 포함한 6~20자리만 가능합니다";
		span.style.color = "red";
		result = false;
	}else{
		span.style.visibility = "hidden";
		span.textContent = "";
	}

	value = document.getElementById("passcheck").value;
	span = document.getElementById("passcheckSpan");	
	var passValue = document.getElementById("pass").value;
	if(value == ""){
		span.style.visibility = "visible";
		span.textContent = "비밀번호를 다시 입력하세요";
		span.style.color = "red";
		result = false;
	}else if(value != passValue){
		span.style.visibility = "visible";
		span.textContent = "비밀번호가 다릅니다";
		span.style.color = "red";
		result = false;
	}else{
		span.style.visibility = "hidden";
		span.textContent = "";
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

	if(result){
		document.modifyFrm.method = "post";
		document.modifyFrm.action = "memberModifyOk.jsp";
		document.modifyFrm.submit();
	}
}

function cancelFn(){
	location.href="mypage.jsp";
}