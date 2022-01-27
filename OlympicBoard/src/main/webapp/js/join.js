function onBlurFn(obj){
	var value = obj.value;
	var span = obj.parentElement.parentElement.getElementsByTagName("span")[1];
	var id = obj.id;
	var reg = "";
	var passValue = document.getElementById("pass").value;
	var ph1Val = document.getElementById("phone1").value;
	var ph2Val = document.getElementById("phone2").value;
	var ph3Val = document.getElementById("phone3").value;
	var ph1Reg = /\d{2,3}/;
	var ph2Reg = /\d{3,4}/;
	var ph3Reg = /\d{4}/;
	var bir1Val = document.getElementById("birth1").value;
	var bir2Val = document.getElementById("birth2").value;
	var bir3Val = document.getElementById("birth3").value;
	var bir1Reg = /\d{4}/;
	var bir2Reg = /\d{1,2}/;
	var bir3Reg = /\d{1,2}/;

	if(id =="id"){			
		reg = /^[a-z]+[a-z0-9]{5,19}$/g;
		$.ajax({
			url: "idcheck.jsp",			
			type: "post",
			data: "value="+value,
			success: function(data){				
				var json = JSON.parse(data.trim());				
				if(json.length != 0){
					span.style.visibility = "visible";
					span.textContent = "중복된 아이디입니다";
					span.style.color = "red";
				}else{
					if(value == ""){
						span.style.visibility = "visible";
						span.textContent = "아이디를 입력하세요";
						span.style.color = "red";
					}else if(!reg.test(value)){
						span.style.visibility = "visible";
						span.textContent = "영문으로 시작하는 6~20자리의 영문or숫자만 가능합니다";
						span.style.color = "red";
					}else{
						span.style.visibility = "visible";
						span.textContent = "사용 가능한 아이디입니다";
						span.style.color = "green";
					}
				}
			}
		});
	}else if(id =="pass"){			
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
			span.textContent = "올바르게 입력하셨습니다";
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
		}
	}

	if(id =="phone1"){
		if(ph1Reg.test(ph1Val) && ph2Reg.test(ph2Val) && ph3Reg.test(ph3Val)){
			span.style.visibility = "visible";
			span.textContent = "올바르게 입력하셨습니다";
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
			span.textContent = "올바르게 입력하셨습니다";
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
			span.textContent = "올바르게 입력하셨습니다";
			span.style.color = "green";
		}else{
			span.style.visibility = "visible";
			span.textContent = "연락처를 올바르게 입력해주세요";
			span.style.color = "red";				
		}
	}

	if(id =="birth1"){			
		if(bir1Reg.test(bir1Val) && bir2Reg.test(bir2Val) && bir3Reg.test(bir3Val) 
		&& bir1Val!="0000" && bir2Val!="0" && bir2Val!="00" && bir3Val!="0" && bir3Val!="00" 
		&& parseInt(bir2Val)<=12 && parseInt(bir3Val)<=31){
			span.style.visibility = "visible";
			span.textContent = "올바르게 입력하셨습니다";
			span.style.color = "green";
		}else if(value == "0000"){
			span.style.visibility = "visible";
			span.textContent = "0은 입력하실 수 없습니다";
			span.style.color = "red";
		}else{
			span.style.visibility = "visible";
			span.textContent = "생년월일을 올바르게 입력해주세요";
			span.style.color = "red";
		}
	}
	if(id =="birth2"){			
		if(bir1Reg.test(bir1Val) && bir2Reg.test(bir2Val) && bir3Reg.test(bir3Val) 
		&& bir1Val!="0000" && bir2Val!="0" && bir2Val!="00" && bir3Val!="0" && bir3Val!="00" 
		&& parseInt(bir2Val)<=12 && parseInt(bir3Val)<=31){
			span.style.visibility = "visible";
			span.textContent = "올바르게 입력하셨습니다";
			span.style.color = "green";
		}else if(value == "0" || value == "00"){
			span.style.visibility = "visible";
			span.textContent = "0은 입력하실 수 없습니다";
			span.style.color = "red";
		}else if(parseInt(value)>12){
			span.style.visibility = "visible";
			span.textContent = "출생월은 12 이하로 입력하세요";
			span.style.color = "red";
		}else{
			span.style.visibility = "visible";
			span.textContent = "생년월일을 올바르게 입력해주세요";
			span.style.color = "red";
		}
	}
	if(id =="birth3"){
		if(bir1Reg.test(bir1Val) && bir2Reg.test(bir2Val) && bir3Reg.test(bir3Val) 
		&& bir1Val!="0000" && bir2Val!="0" && bir2Val!="00" && bir3Val!="0" && bir3Val!="00" 
		&& parseInt(bir2Val)<=12 && parseInt(bir3Val)<=31){
			span.style.visibility = "visible";
			span.textContent = "올바르게 입력하셨습니다";
			span.style.color = "green";
		}else if(value == "0" || value == "00"){
			span.style.visibility = "visible";
			span.textContent = "0은 입력하실 수 없습니다";
			span.style.color = "red";
		}else if(parseInt(value)>31){
			span.style.visibility = "visible";
			span.textContent = "출생일은 31 이하로 입력하세요";
			span.style.color = "red";
		}else{
			span.style.visibility = "visible";
			span.textContent = "생년월일을 올바르게 입력해주세요";
			span.style.color = "red";
		}
	}
}

function joinSubmitFn(){
	var result = true;

	var value = document.getElementById("id").value;
	var span = document.getElementById("idSpan");
	var reg = /^[a-z]+[a-z0-9]{5,19}$/g;
		
	$.ajax({
		url: "idcheck.jsp",
		type: "post",
		data: "value="+value,
		success: function(data){
			var json = JSON.parse(data.trim());				
			if(json.length != 0){
				document.getElementById("idSpan").style.visibility = "visible";
				document.getElementById("idSpan").textContent = "중복된 아이디입니다";
				document.getElementById("idSpan").style.color = "red";
				result = false;
			}
		}
	});
	if(value == ""){
		span.style.visibility = "visible";
		span.textContent = "아이디를 입력하세요";
		span.style.color = "red";
		result = false;
	}else if(!reg.test(value)){
		span.style.visibility = "visible";
		span.textContent = "영문으로 시작하는 6~20자리의 영문or숫자만 가능합니다";
		span.style.color = "red";
		result = false;
	}else{
		span.style.visibility = "hidden";
		span.textContent = "";
	}

	value = document.getElementById("pass").value;
	span = document.getElementById("passSpan");
	reg = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{6,20}$/;
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
	passValue = document.getElementById("pass").value;
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

	value = document.getElementById("name").value;
	span = document.getElementById("nameSpan");
	reg = reg = /[가-힣]{2,20}$/;
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
	var ph1Reg = /\d{2,3}/;
	var ph2Reg = /\d{3,4}/;
	var ph3Reg = /\d{4}/;		
	if(ph1Reg.test(ph1Val) && ph2Reg.test(ph2Val) && ph3Reg.test(ph3Val)){
		span.style.visibility = "hidden";
		span.textContent = "";
	}else{
		span.style.visibility = "visible";
		span.textContent = "연락처를 올바르게 입력해주세요";
		span.style.color = "red";
		result = false;
	}

	span = document.getElementById("birthSpan");
	var bir1Val = document.getElementById("birth1").value;
	var bir2Val = document.getElementById("birth2").value;
	var bir3Val = document.getElementById("birth3").value;
	var bir1Reg = /\d{4}/;
	var bir2Reg = /\d{1,2}/;
	var bir3Reg = /\d{1,2}/;
	if(bir1Reg.test(bir1Val) && bir2Reg.test(bir2Val) && bir3Reg.test(bir3Val) 
		&& bir1Val!="0000" && bir2Val!="0" && bir2Val!="00" && bir3Val!="0" && bir3Val!="00" 
		&& parseInt(bir2Val)<=12 && parseInt(bir3Val)<=31){
		span.style.visibility = "hidden";
		span.textContent = "";
	}else if(bir1Val=="0000" || bir2Val=="0" || bir2Val=="00" || bir3Val=="0" || bir3Val=="00"){
		span.style.visibility = "visible";
		span.textContent = "0은 입력하실 수 없습니다";
		span.style.color = "red";
		result = false;
	}else if(parseInt(bir2Val)>12){
		span.style.visibility = "visible";
		span.textContent = "출생월은 12 이하로 입력하세요";
		span.style.color = "red";
		result = false;
	}else if(parseInt(bir3Val)>31){
		span.style.visibility = "visible";
		span.textContent = "출생일은 31 이하로 입력하세요";
		span.style.color = "red";
		result = false;
	}else{
		span.style.visibility = "visible";
		span.textContent = "생년월일을 올바르게 입력해주세요";
		span.style.color = "red";
		result = false;
	}

	if(result){
		document.joinFrm.method = "post";
		document.joinFrm.action = "joinOk.jsp";
		document.joinFrm.submit();
	}
}