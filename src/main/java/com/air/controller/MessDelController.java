package com.air.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.air.dao.MessageDAO;
import com.air.dao.MessageDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delete")
public class MessDelController extends HttpServlet {

	private static final long serialVersionUID = 2593666006947612187L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 클라이언트에게 전달한 HTML 페이지 생성
		resp.setContentType("text/html");

		PrintWriter out = resp.getWriter();

		// form으로부터 전송된 데이터
		String hidd = req.getParameter("hidd1");

		if (hidd.equals("success")) {
			deleteMember(req);
//			req.getRequestDispatcher("/user/Message.jsp").forward(req, resp); // 성공 페이지로 리다이렉트
			out.println("<html>");
			out.println("<body>");
			out.println("<script>");
			out.println("alert('해지 신청이 완료 되었습니다.');");
			out.println("</script>");
			out.println("</body>");
			out.println("</html>");
			out.print("<script>location.href='http://localhost:8080/air/user/Message.jsp'</script>");
		} else {
			System.out.println("인증번호 실패");
			out.println("<html>");
			out.println("<body>");
			out.println("<script>");
			out.println("alert('해지 신청이 실패하였습니다.');");
			out.println("</script>");
			out.println("</body>");
			out.println("</html>");
			// 인증 실패 시 처리
			out.print("<script>location.href='http://localhost:8080/air/user/Message.jsp'</script>");

		}
	}

	private void deleteMember(HttpServletRequest req) {
		MessageDTO dto = new MessageDTO();

		dto.setMessage_phone(req.getParameter("member_phone"));

		MessageDAO dao = new MessageDAO();
		int cnt = dao.deleteMessage(dto);

		if (cnt > 0) {
			System.out.println("회원삭제 성공");
		} else {
			System.out.println("회원삭제 실패");
		}
	}
}
