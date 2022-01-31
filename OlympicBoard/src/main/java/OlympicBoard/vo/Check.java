package OlympicBoard.vo;

public class Check {
	
	public String loginCheck;
	public String joinCheck;	
	public String id;
	public String idCheck;
	public boolean passCheck;
	public boolean sendId;
	public boolean sendPass;
	
		
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

	public String getIdCheck() {
		return idCheck;
	}

	public void setIdCheck(String idCheck) {
		this.idCheck = idCheck;
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
