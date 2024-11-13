package com.air.controller;

import com.air.dao.BoardDAO;
import com.air.dao.BoardDTO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("*.notice")
public class NoticeController extends HttpServlet {

	private static final long serialVersionUID = 3212548447918831320L;

	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		if (req.getRequestURI().contains("insert")) {
			// 새로운 게시글 작성
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			String id = "admin"; // 사용자 ID
			String file = ""; // 파일 관련 처리 추가 필요

			BoardDTO boardDTO = new BoardDTO();
			boardDTO.setTitle(title);
			boardDTO.setContent(content);
			boardDTO.setId(id);
			boardDTO.setFile(file);

			BoardDAO dao = new BoardDAO();
			dao.insertBoard(boardDTO);

			req.getRequestDispatcher("view.notice").forward(req, resp);
			System.out.println("insert실행");
		}
		// 게시글 보기 요청 처리
		else if (req.getRequestURI().contains("view")) {
		    BoardDAO dao = new BoardDAO();
		    List<BoardDTO> list = dao.selectBoard();

		    ServletContext application = req.getServletContext();
		    
		    // 게시물 총 갯수
		    int listSize = list.size(); 
		    
		    int postCnt = Integer.parseInt(application.getInitParameter("postCnt"));
		   
		    int pageCnt = Integer.parseInt(application.getInitParameter("pageCnt"));

		    
		    
		    int currentPage = 1;
		    String pageReq = req.getParameter("pageNum");
		    if (pageReq != null) {
		        currentPage = Integer.parseInt(pageReq);
		    }
		    
		    // 1페이지는 0~9
			// 2페이지는 10~19 
			// 3페이지는 20~29
		    int start=currentPage*postCnt-postCnt;
			int end=start+(postCnt-1);

		    int pageSize = (int) Math.ceil(1.0 * listSize / postCnt);
		    int pagePage = (int) Math.ceil(1.0 * currentPage / 5);
		   
		    int startPage = (pagePage - 1) * 5 + 1;
		    int endPage = Math.min(startPage + 4, pageSize);
		


		    req.setAttribute("list", list);
		    req.setAttribute("start", start);
		    req.setAttribute("end", end);
		    req.setAttribute("startPage", startPage);
		    req.setAttribute("endPage", endPage);
		    req.setAttribute("pageSize", pageSize);
		    req.setAttribute("pagePage", pagePage);
		    req.setAttribute("currentPage", currentPage);

		    req.getRequestDispatcher("/user/Notice.jsp").forward(req, resp);

		    System.out.println("view실행");
		}
		// 게시글 상세보기
		else if (req.getRequestURI().contains("detail")) {
			String numParam = req.getParameter("num");
			if (numParam != null) {
				int num = Integer.parseInt(numParam);
				BoardDAO dao = new BoardDAO();
				List<BoardDTO> detailList = dao.detailBoard(num);
				dao.boardCnt(num);
				req.setAttribute("detailList", detailList);
				req.getRequestDispatcher("/user/NoticeView.jsp").forward(req, resp);

				System.out.println("detail실행");
			}
		}
		// 게시글 검색
		else if (req.getRequestURI().contains("search")) {
			String keyword = req.getParameter("keyword"); // 검색어를 받아옴

			if (keyword != null && !keyword.isEmpty()) { // 검색어가 유효한지 확인
				BoardDAO dao = new BoardDAO();
				List<BoardDTO> searchResult = dao.searchBoard(keyword); // 검색어를 기준으로 게시글 검색

				if (!searchResult.isEmpty()) { // 검색 결과가 비어있지 않은지 확인
					req.setAttribute("searchResult", searchResult); // 검색 결과를 request에 설정하여 JSP로 전달
				} else {
					// 검색 결과가 없을 경우에 대한 처리
					req.setAttribute("message", "\" " +  keyword  + "\"검색 결과가 없습니다.");
				}
			} else {
				// 검색어가 없을 경우에 대한 처리
				req.setAttribute("message", "검색어를 입력하세요.");
			}
			// 검색 결과가 있는지 여부에 상관없이 결과 페이지로 포워딩
			req.getRequestDispatcher("/user/SearchResult.jsp").forward(req, resp);
			System.out.println("search 실행");
		}
		// 게시글 삭제
		else if (req.getRequestURI().contains("del")) {
			String numParam1 = req.getParameter("num"); // 삭제할 게시글의 번호
			if (numParam1 != null) {
				int num = Integer.parseInt(numParam1); // 번호를 정수로 변환
				BoardDAO dao = new BoardDAO();
				dao.delNotice(num); // 번호를 기준으로 게시글 삭제
			}

			req.getRequestDispatcher("view.notice").forward(req, resp);

			System.out.println("del실행");
		}
		// 게시글 수정
		else if (req.getRequestURI().contains("update")) {
			if (req.getMethod().equals("POST")) {
				// 수정 완료 버튼을 클릭한 경우
				int num = Integer.parseInt(req.getParameter("num"));
				String title = req.getParameter("title");
				String content = req.getParameter("content");

				BoardDTO dto = new BoardDTO();
				dto.setNum(num);
				dto.setTitle(title);
				dto.setContent(content);

				BoardDAO dao = new BoardDAO();
				int result = dao.updateBoard(dto);

				if (result > 0) {
					// 수정이 성공하면 notice 페이지로 리다이렉션
					resp.sendRedirect(req.getContextPath() + "/view.notice?num=" + num);
				} else {
					// 수정 실패 시 처리
					// 실패 시 예외 처리 등
				}
			}
			else {
				// 수정 페이지로 이동하는 GET 요청 처리
				String numParam1 = req.getParameter("num");
				if (numParam1 != null) {
					int num = Integer.parseInt(numParam1);
					BoardDAO dao = new BoardDAO();
					List<BoardDTO> detailList = dao.detailBoard(num);

					if (!detailList.isEmpty()) {
						BoardDTO detail = detailList.get(0); // 상세 정보가 여러 개가 아닌 경우 첫 번째 요소만 사용
						req.setAttribute("detail", detail); // 상세 정보를 request에 설정하여 JSP로 전달
						req.getRequestDispatcher("/user/Update.jsp").forward(req, resp);
						System.out.println("수정 페이지로 이동");
					} else {
						// 해당 번호의 게시글이 없는 경우 처리
						// 실패 시 예외 처리 등
					}
				}
			}
		}
	}
}
