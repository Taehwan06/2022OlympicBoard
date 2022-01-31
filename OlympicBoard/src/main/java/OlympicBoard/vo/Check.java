package OlympicBoard.vo;

public class Check {
	
	public String loginCheck;
	public String joinCheck;
	public String idCheck;
	public String id;
	public boolean sendId;
	
		
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
