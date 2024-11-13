package com.air.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet ("*.do")

public class PageController extends HttpServlet{

	private static final long serialVersionUID = -2810369719622651818L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getRequestURI();
		if(path.contains("Index")) {
			resp.sendRedirect("./Index.jsp");
		}
		else if(path.contains("NoticeView")) {//공지사항 뷰
			resp.sendRedirect("./NoticeView.jsp");
		}
		else if(path.contains("NoticeRegister")) {//공지사항 등록
			resp.sendRedirect("../manager/NoticeRegister.jsp");
		}
		else if(path.contains("Notice")) {//공지사항
			resp.sendRedirect("./Notice.jsp");
		}
		else if(path.contains("Login")) {//로그인
			resp.sendRedirect("../Include/Login.jsp");
		}
		else if(path.contains("Message")) {//문자서비스
			resp.sendRedirect("./Message.jsp");
		}
		else if(path.contains("Info")) {//미세먼지 정보
			resp.sendRedirect("./Info.jsp");
		}
		else if(path.contains("VisualGraph")) {//시각화자료
			resp.sendRedirect("./VisualGraph.jsp");
		}
		else if(path.contains("Monitoring")) {//모니터링
			resp.sendRedirect("./Monitoring.jsp");
		}
		
		
		
//		req.setAttribute("path", path);
//		req.getRequestDispatcher("/user/Index.jsp").forward(req, resp);
	}
	
	
	
	
	
	

}
