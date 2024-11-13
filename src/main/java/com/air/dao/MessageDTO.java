package com.air.dao;

import java.sql.Timestamp;

public class MessageDTO {

	// 카운트
	private int cnt;
	// 이름
	private String message_name;
	// 핸드폰 번호
	private String message_phone;
	// 알림지역
	private String message_area;
	
	public int getCnt() {
		return cnt;
	}
	
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	public String getMessage_name() {
		return message_name;
	}
	
	public void setMessage_name(String message_name) {
		this.message_name = message_name;
	}
	
	public String getMessage_phone() {
		return message_phone;
	}
	
	public void setMessage_phone(String message_phone) {
		this.message_phone = message_phone;
	}
	
	public String getMessage_area() {
		return message_area;
	}
	
	public void setMessage_area(String message_area) {
		this.message_area = message_area;
	}


}
