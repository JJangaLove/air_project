package com.air.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	private Connection con;
	private PreparedStatement psmt;
	private ResultSet rs;

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
	// 게시글 등록
	public int insertBoard(BoardDTO dto) {
		getConnection();
		
		 System.out.println("insertBoard 실행: " + dto.getTitle());

		int cnt = -1;

		String sql = "INSERT INTO post(post_title, post_content, post_date, post_id, post_file, post_cnt) VALUES ( ?, ?, NOW(), ?, ?, 0)";

		try {
			PreparedStatement psmt = con.prepareStatement(sql);

			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			psmt.setString(4, dto.getFile());

			cnt = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return cnt;
	}

	// 게시글 리스트
	public List<BoardDTO> selectBoard() {

		getConnection();
		List<BoardDTO> list = new ArrayList<BoardDTO>();

		try {
			String sql = "SELECT * FROM post ORDER BY post_date DESC";
			PreparedStatement psmt = con.prepareStatement(sql);

			rs = psmt.executeQuery();

			while (rs.next()) {

				BoardDTO dto = new BoardDTO();

				dto.setNum(rs.getInt("post_num"));
				dto.setTitle(rs.getString("post_title"));
				dto.setContent(rs.getString("post_content"));
				dto.setDate(rs.getTimestamp("post_date"));
				dto.setId(rs.getString("post_id"));
				dto.setFile(rs.getString("post_file"));
				dto.setCnt(rs.getInt("post_cnt"));

				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			// 예외 처리
		} finally {
			close();
		}

		return list;
	}

	// 게시글 상세보기
	public List<BoardDTO> detailBoard(int num) {

		getConnection();
		List<BoardDTO> list2 = new ArrayList<BoardDTO>();

		try {
			String sql = "SELECT * FROM post where post_num=? ";

			PreparedStatement psmt = con.prepareStatement(sql);
			psmt.setInt(1, num);

			rs = psmt.executeQuery();

			while (rs.next()) {

				BoardDTO dto = new BoardDTO();

				dto.setNum(rs.getInt("post_num"));
				dto.setTitle(rs.getString("post_title"));
				dto.setContent(rs.getString("post_content"));
				dto.setDate(rs.getTimestamp("post_date"));
				dto.setId(rs.getString("post_id"));
				dto.setFile(rs.getString("post_file"));
				dto.setCnt(rs.getInt("post_cnt"));

				list2.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			// 예외 처리
		} finally {
			close();
		}

		return list2;
	}
	//게시글 검색
	public List<BoardDTO> searchBoard(String keyword) {
	    List<BoardDTO> searchResult = new ArrayList<>();
	    getConnection();
	    try {
	        String sql = "SELECT * FROM post WHERE post_title LIKE ? OR post_content LIKE ?";
	        PreparedStatement psmt = con.prepareStatement(sql);
	        psmt.setString(1, "%" + keyword + "%");
	        psmt.setString(2, "%" + keyword + "%");
	        ResultSet rs = psmt.executeQuery();
	        while (rs.next()) {
	            BoardDTO board = new BoardDTO();
	            board.setNum(rs.getInt("post_num"));
	            board.setTitle(rs.getString("post_title"));
	            board.setContent(rs.getString("post_content"));
	            board.setDate(rs.getTimestamp("post_date"));
	            searchResult.add(board);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close();
	    }
	    System.out.println("searchBoard 실행:");
	    return searchResult;
	}
	public ArrayList<BoardDTO> selectList(Map<String, Object> map) {
	    getConnection();
	    ArrayList<BoardDTO> bbs = new ArrayList<BoardDTO>();
	    
	    String query = "SELECT * FROM post";
	    if (map.get("keyword") != null) {
	        query += " WHERE post_title LIKE ? OR post_content LIKE ?";
	    }
	    query += " ORDER BY post_date DESC";
	    
	    try {
	        PreparedStatement psmt = con.prepareStatement(query);
	        if (map.get("keyword") != null) {
	            String keyword = "%" + map.get("keyword") + "%";
	            psmt.setString(1, keyword);
	            psmt.setString(2, keyword);
	        }
	        
	        ResultSet rs = psmt.executeQuery();
	        
	        while (rs.next()) {
	            BoardDTO dto = new BoardDTO();
	            dto.setNum(rs.getInt("post_num"));
	            dto.setTitle(rs.getString("post_title"));
	            dto.setContent(rs.getString("post_content"));
	            dto.setDate(rs.getTimestamp("post_date"));
	            dto.setId(rs.getString("post_id"));
	            dto.setFile(rs.getString("post_file"));
	            dto.setCnt(rs.getInt("post_cnt"));

	            bbs.add(dto);
	        }
	    } catch (SQLException e) {
	        System.out.println("게시물 조회 중 예외 발생");
	        e.printStackTrace();
	    } finally {
	        close();
	    }
	    return bbs;
	}
	// 게시글 수정
	public int updateBoard(BoardDTO dto) {
	    getConnection();
	    int result = -1;

	    try {
	        String sql = "UPDATE post SET post_title=?, post_content=? WHERE post_num=?";
	        psmt = con.prepareStatement(sql);

	        psmt.setString(1, dto.getTitle());
	        psmt.setString(2, dto.getContent());
	        psmt.setInt(3, dto.getNum());

	        result = psmt.executeUpdate();

	        if (result > 0) {
	            System.out.println("게시글 수정 완료");
	        } else {
	            System.out.println("수정된 게시글이 없습니다.");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close();
	    }
	    return result;
	}
	// 게시글 조회수
	public void boardCnt(int num) {

		getConnection();
		try {           
			String sql = "UPDATE post SET post_cnt = post_cnt + 1 WHERE post_num = ?";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, num);
			psmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

		}
	}

	// 게시글 삭제
	public void delNotice(int num) {
		getConnection();
		String sql = "DELETE FROM post WHERE post_num=?";
		try {
			PreparedStatement psmt = con.prepareStatement(sql);
			psmt.setInt(1, num);
			int result = psmt.executeUpdate();
			if (result > 0) {
				System.out.println("게시글 삭제 완료");
			} else {
				System.out.println("삭제된 게시글이 없습니다.");
			}
		} catch (Exception e) {
			System.out.println("삭제 중 예외발생!");
			e.printStackTrace();
		} finally {
			close();
		}
	}

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