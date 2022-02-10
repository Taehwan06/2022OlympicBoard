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
	
	if(id =="name"){
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

function findIdFn(){
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
		document.findIdFrm.method = "post";
		document.findIdFrm.action = "findIdOk.jsp";
		document.findIdFrm.submit();
	}
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
