package com.air.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.air.dao.PastdbDAO;
import com.air.dao.PastdbDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Past")
public class PastdbController extends HttpServlet {

	private static final long serialVersionUID = 2465814174507161526L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		processRequest(req, resp);
	}

	private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");

		String area = req.getParameter("select_value");
		PastdbDAO dao = new PastdbDAO();
		List<PastdbDTO> list = dao.selectPast(area);
		System.out.println("list : " + list.toString());
		
		// json으로 지역 다시 보내기
		JSONObject json = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		// 데이터를 JSON 형식으로 변환하여 JSONArray에 추가
		for (PastdbDTO data : list) {
			JSONObject jsonO = new JSONObject();
			jsonO.put("SO2", data.getSo2());
			jsonO.put("CO", data.getCo());
			jsonO.put("O3", data.getO3());
			jsonO.put("NO2", data.getNo2());
			jsonO.put("PM10", data.getPm10());
			jsonO.put("PM25", data.getPm25());
			jsonO.put("MONTH", data.getMonth());
			
			jsonArray.put(jsonO);
		}
		json.put("list", jsonArray);
		System.out.println("json 값 :" + json.toString());
		out.print(json.toString());
		out.flush();
		
		
//		req.setAttribute("list", list);
//		System.out.println("list : " + list.size());
//		req.getRequestDispatcher("Monitoring.jsp").forward(req, resp);
		
	}
	
}
