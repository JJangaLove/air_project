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

public class PastdbDAO {
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

	// 지역 기준으로 검색
	public List<PastdbDTO> selectPast(String keyword) {
		List<PastdbDTO> list = new ArrayList<PastdbDTO>();
		getConnection();

		try {
			String sql = "SELECT * FROM pastdb WHERE Area=?";
			PreparedStatement psmt = con.prepareStatement(sql);
			psmt.setString(1, keyword);
			ResultSet rs = psmt.executeQuery();

			while (rs.next()) {
				PastdbDTO past = new PastdbDTO();
				past.setSo2(rs.getDouble("SO2"));
				past.setCo(rs.getDouble("CO"));
				past.setO3(rs.getDouble("O3"));
				past.setNo2(rs.getDouble("NO2"));
				past.setPm10(rs.getDouble("PM10"));
				past.setPm25(rs.getDouble("PM25"));
				past.setMonth(rs.getInt("month"));
				
				list.add(past);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		System.out.println("Area 값 : " + keyword);
		return list;
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
