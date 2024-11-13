package com.air.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LoginDAO {
	private Connection con; //DB와 연결
	private PreparedStatement psmt; 
	private ResultSet rs;
	
	//DB 커넥션 연결
	public void getConnection() {
		try {
			Context initCtx = new InitialContext();
			Context ctx = (Context) initCtx.lookup("java:comp/env");
			DataSource source = (DataSource) ctx.lookup("DBPool");

			con = source.getConnection();
			System.out.println("DB 커넥션 풀 연결 성공");
		} catch (Exception e) {
			System.out.println("DB 커넥션 풀 연결 실패");
			e.printStackTrace();
		}
	}
	
	//로그인
	public LoginDTO searchLogin(String id, String pw) {
	    getConnection();
	    LoginDTO dto = null;

	    String sql = "SELECT * FROM manager WHERE manager_id=? AND manager_pw=?";

	    try {
	        PreparedStatement psmt = con.prepareStatement(sql);
	        psmt.setString(1, id);
	        psmt.setString(2, pw);
	        rs = psmt.executeQuery();

	        while (rs.next()) {
	        	dto = new LoginDTO();
	        	dto.setManager_id(rs.getString("manager_id"));
        		dto.setManager_pw(rs.getString("manager_pw"));
	        }
	        System.out.println("dao id 값 : "+dto.getManager_id());
	     
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close();
	    }

	    return dto;
	}
	
	
	//연결 해제(자원 반납)
	public void close() {
		try {
			if(rs != null) rs.close();
			if(psmt != null) psmt.close();
			if(con != null) con.close();
			
			System.out.println("DB 커넥션 풀 자원 반납");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}
