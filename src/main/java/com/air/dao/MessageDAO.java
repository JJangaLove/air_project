package com.air.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MessageDAO {
	private Connection con;
	private PreparedStatement psmt;
	private ResultSet rs;

	// DB 연결
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

	// DB에 미세먼지 정보 받을 회원 정보 입력
	public int insertMessage(MessageDTO dto) {
		getConnection();

		int cnt = -1;

		String sql = "INSERT INTO message(message_name, message_phone, message_area) VALUES ( ?, ?, ?)";

		try {
			psmt = con.prepareStatement(sql);

			psmt.setString(1, dto.getMessage_name());
			psmt.setString(2, dto.getMessage_phone());
			psmt.setString(3, dto.getMessage_area());

			cnt = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return cnt;
	}
	
	// 지역 기준으로 검색
		public List<MessageDTO> selectMessage(String keyword) {
			List<MessageDTO> list = new ArrayList<MessageDTO>();
			getConnection();

			try {
				String sql = "SELECT * FROM message WHERE message_area=?";
				PreparedStatement psmt = con.prepareStatement(sql);
				psmt.setString(1, keyword);
				ResultSet rs = psmt.executeQuery();

				while (rs.next()) {
					MessageDTO mess = new MessageDTO();
					mess.setMessage_phone(rs.getString("message_phone"));
					mess.setMessage_area(rs.getString("message_area"));
					
					list.add(mess);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			System.out.println("Area 값 : " + keyword);
			return list;
		}

	// DB 회원 삭제
	public int deleteMessage(MessageDTO dto) {
		getConnection();

		int cnt = -1;

		String sql = "delete from message where message_phone=?";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getMessage_phone());

			cnt = psmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}

	// DB 연결 해제
	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (psmt != null)
				psmt.close();
			if (con != null)
				con.close();

			System.out.println("DB 커넥션 풀 자원 반납");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
