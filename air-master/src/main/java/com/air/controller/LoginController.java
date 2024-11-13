package com.air.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpSession;

import org.springframework.web.context.annotation.SessionScope;

import com.air.dao.LoginDAO;
import com.air.dao.LoginDTO;
import com.mysql.cj.Session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("*.login")
public class LoginController extends HttpServlet {

	private static final long serialVersionUID = -5417057660236625232L;
	private jakarta.servlet.http.HttpSession session;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");
		String path = req.getRequestURI();
		int fail = 0; //로그인 실패
		if(path.contains("login")) {
			LoginDTO dto = new LoginDTO();
			LoginDAO dao = new LoginDAO();
			

			String id = req.getParameter("loginId");
			System.out.println("컨트롤러 id값" + id);
			String pw = req.getParameter("loginPwd");
			try {
				
				dto = dao.searchLogin(id, pw);
				
				session = req.getSession();
				session.setAttribute("loginId", dto.getManager_id());
				if(dto != null) {
					System.out.println("로그인 컨트롤러 실행");
					resp.sendRedirect("/air/user/Index.jsp");
				}
			}catch(Exception e){
				out.println("<script> alert('아이디 혹은 비밀번호가 틀립니다. 다시 로그인해주세요.')");
				out.println("history.go(-1)</script>");
			}
			
			
			out.close();
		}
	}
	
	

	
}
