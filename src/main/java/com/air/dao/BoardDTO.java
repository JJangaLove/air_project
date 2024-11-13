package com.air.dao;
import java.sql.Timestamp;

public class BoardDTO {

	private int num;
	private String title;
	private String content;
	private Timestamp date;
	private String id;
	private String file;
	private int cnt;

	public BoardDTO() {

	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	@Override
	public String toString() {
		String str="게시글번호="+getNum()+"제목="+getTitle()+"내용="+getContent()+"날짜="+getDate()+"관리자="+getId()+"조회수="+getCnt(); 
		return str;
	}

}	