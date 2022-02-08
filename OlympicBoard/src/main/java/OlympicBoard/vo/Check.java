package OlympicBoard.vo;

public class Check {
	
	public String loginCheck;
	public String joinCheck;	
	public String id;
	public boolean idConfirm;
	public boolean idCheck;
	public boolean passCheck;
	public boolean sendId;
	public boolean sendPass;
	public String memberModify;
	public String withdraw;
	public boolean writeCheck;
	
	
	public boolean isWriteCheck() {
		return writeCheck;
	}

	public void setWriteCheck(boolean writeCheck) {
		this.writeCheck = writeCheck;
	}

	public String getWithdraw() {
		return withdraw;
	}

	public void setWithdraw(String withdraw) {
		this.withdraw = withdraw;
	}

	public String getMemberModify() {
		return memberModify;
	}

	public void setMemberModify(String memberModify) {
		this.memberModify = memberModify;
	}

	public boolean isIdConfirm() {
		return idConfirm;
	}

	public void setIdConfirm(boolean idConfirm) {
		this.idConfirm = idConfirm;
	}

	public boolean isIdCheck() {
		return idCheck;
	}

	public void setIdCheck(boolean idCheck) {
		this.idCheck = idCheck;
	}

	public boolean isPassCheck() {
		return passCheck;
	}

	public void setPassCheck(boolean passCheck) {
		this.passCheck = passCheck;
	}

	public boolean isSendPass() {
		return sendPass;
	}

	public void setSendPass(boolean sendPass) {
		this.sendPass = sendPass;
	}

	public boolean isSendId() {
		return sendId;
	}

	public void setSendId(boolean sendId) {
		this.sendId = sendId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getJoinCheck() {
		return joinCheck;
	}

	public void setJoinCheck(String joinCheck) {
		this.joinCheck = joinCheck;
	}

	public String getLoginCheck() {
		return loginCheck;
	}

	public void setLoginCheck(String loginCheck) {
		this.loginCheck = loginCheck;
	}			
}
