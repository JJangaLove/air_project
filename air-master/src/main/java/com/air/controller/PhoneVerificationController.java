package com.air.controller;

import java.io.IOException;
import java.io.PrintWriter;

import org.json.JSONObject;

import com.mysql.cj.Session;

import jakarta.security.auth.message.callback.PrivateKeyCallback.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@WebServlet("/phone")
public class PhoneVerificationController extends HttpServlet {

	private static final long serialVersionUID = -217633677759346045L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		req.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");

		// 클라이언트에서 전송된 휴대폰 번호 받기
		String phoneNumber = req.getParameter("phoneNumber");

		// 휴대폰 번호 유효성 검사 및 인증 번호 생성
		String certification = generateCertification();

		// 생성된 인증번호를 세션에 저장
//		req.getSession().setAttribute("certification", certification);
//		req.setAttribute("certification", certification);
		// json으로 인증번호 보내기
		JSONObject json = new JSONObject();
		json.put("certification", certification);
		out.print(json);

		// 인증 번호를 SMS로 사용자에게 전송
		sendSMSCertification(phoneNumber, certification);

		// 클라이언트에 응답 보내기
//		resp.getWriter().write("certification sent to " + phoneNumber);
		out.close();
		// 다시 돌아가기
//		req.getRequestDispatcher("/user/Message.jsp").forward(req, resp);
	}

	private String generateCertification() {
		// 인증 번호 생성 로직구현
		int code = (int) ((Math.random() * 899999) + 100000);
		System.out.println(code);
		return String.valueOf(code);
	}

	private void sendSMSCertification(String phoneNumber, String Certification) {
		// API 초기화
		DefaultMessageService messageService = NurigoApp.INSTANCE.initialize("NCSYAENMLV9ZTFI1",
				"4FGT0UGP3YQ497OQKPL92DAZNX6CVVGJ", "https://api.solapi.com");

		// SMS 메시지 생성
		Message message = new Message();
		message.setFrom("01047066002");
		message.setTo(phoneNumber);
		message.setText(Certification);

		try {
			// SMS 전송
			messageService.send(message);
		} catch (NurigoMessageNotReceivedException exception) {
			// 발송 실패 메시지 목록 확인
			System.out.println(exception.getFailedMessageList());
			System.out.println(exception.getMessage());
		} catch (Exception exception) {
			// 기타 예외 처리
			System.out.println(exception.getMessage());
		}
	}
}
