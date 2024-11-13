package com.air.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.crypto.Data;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.air.dao.BoardDAO;
import com.air.dao.BoardDTO;
import com.air.dao.PastdbDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/MainNotice")
public class MainNoticeController extends HttpServlet{

	private static final long serialVersionUID = 8432612420051423545L;
	
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");
		
		BoardDAO dao = new BoardDAO();
	    List<BoardDTO> list = dao.selectBoard();
		
	    JSONObject json = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonO = new JSONObject();
		
		for (BoardDTO data : list) {
			JSONObject jsonG = new JSONObject();
			jsonG.put("title", data.getTitle());
			jsonG.put("date", data.getDate());
			jsonG.put("num", data.getNum());
			
			jsonArray.put(jsonG);
			/* System.out.println(jsonG); */
		}
		
		json.put("list", jsonArray);
		System.out.println("json 값 :" + json.toString());
		out.print(json.toString());
		out.flush();

		
	}

}
