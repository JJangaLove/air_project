package com.air.controller;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

public class messageController {
	public static void main(String[] args) {
		DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize("NCSYAENMLV9ZTFI1", "4FGT0UGP3YQ497OQKPL92DAZNX6CVVGJ", "https://api.solapi.com");
		// Message 패키지가 중복될 경우 net.nurigo.sdk.message.model.Message로 치환하여 주세요
		Message message = new Message();
		message.setFrom("01047066002");
		message.setTo("01047066002");
		message.setText("미세먼지 나쁨입니다 야외 활동을 자제해주세요");
		// message.setSubject("문자 제목 입력"); // LMS, MMS 전용 옵션, SMS에서 해당 파라미터 추가될 경우 자동으로 LMS로 변환됩니다!

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
