package com.air.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.air.dao.MessageDAO;
import com.air.dao.MessageDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@WebServlet("/dustCon")
public class DustController extends HttpServlet {

	private static final long serialVersionUID = 2683878041751069159L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}


	private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 클라이언트에서 요청한 값 받아오기
		String location = req.getParameter("location");
//		System.out.println(location);
		// 값이 null이 아니면 처리 수행
		if (location != null) {
			System.out.println("진행 중");
			MessageDAO dao = new MessageDAO();
			List<MessageDTO> lists = dao.selectMessage(location);
			
			for (MessageDTO list : lists) {
				String phone = list.getMessage_phone();
//				System.out.println(phone);
				String area = list.getMessage_area();
//				System.out.println(area);
				sendMessage(phone, area);
			}
		} else {
			// location이 null인 경우에 대한 처리
			System.out.println("location이 null입니다.");
		}
	}


	private void sendMessage(String phone, String area) {
		DefaultMessageService messageService = NurigoApp.INSTANCE.initialize("NCSYAENMLV9ZTFI1",
				"4FGT0UGP3YQ497OQKPL92DAZNX6CVVGJ", "https://api.solapi.com");
		// Message 패키지가 중복될 경우 net.nurigo.sdk.message.model.Message로 치환하여 주세요

		Message message = new Message();
		message.setFrom("01047066002");
		message.setTo(phone);
		message.setText(area + "지역의 미세먼지 나쁨입니다 야외 활동을 자제해주세요");
		// message.setSubject("문자 제목 입력"); // LMS, MMS 전용 옵션, SMS에서 해당 파라미터 추가될 경우 자동으로
		// LMS로 변환됩니다!

		try {
			// send 메소드로 ArrayList<Message> 객체를 넣어도 동작합니다!
			messageService.send(message);
		} catch (NurigoMessageNotReceivedException exception) {
			// 발송에 실패한 메시지 목록을 확인할 수 있습니다!
			System.out.println(exception.getFailedMessageList());
			System.out.println(exception.getMessage());
		} catch (Exception exception) {
			System.out.println(exception.getMessage());
		}
	}
}
