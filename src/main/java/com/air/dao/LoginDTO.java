package com.air.dao;

public class LoginDTO {
	private String manager_id;
	private String manager_pw;
	
	public String getManager_id() {
		return manager_id;
	}



	public void setManager_id(String manager_id) {
		this.manager_id = manager_id;
	}



	public String getManager_pw() {
		return manager_pw;
	}



	public void setManager_pw(String manager_pw) {
		this.manager_pw = manager_pw;
	}



	@Override
	public String toString() {
		String str = "아이디"+getManager_id()+"비밀번호"+getManager_pw();
		return str;
	}
	
	
}
