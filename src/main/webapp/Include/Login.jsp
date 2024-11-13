<%@page import="com.air.dao.LoginDTO"%>
<%@page import="com.air.dao.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String loginId = request.getParameter("id");
session.setAttribute("loginId", loginId);
%>
	<jsp:include page="/Include/Header.jsp" />
	
  	<div class="login_wrap">
        <div class="header_txt">
            <h1>로그인</h1>
            <h2><i class="fas fa-exclamation"></i> 관리자 전용 로그인 페이지입니다. 일반 사용자들은 로그인이 불가합니다.</h2>
        </div>

        <div class="login_cont">
            <div class="login_form">
                <form action="<%= request.getContextPath() %>/login.login" method="post">
                    <div>
                        <label for="loginId">아이디</label>
                        <input type="text" id="loginId" name="loginId" value="" placeholder="아이디를 입력해주세요.">
                    </div>
                    <div>
                        <label for="loginPwd">비밀번호</label>
                        <input type="password" id="loginPwd" name="loginPwd" value="" placeholder="비밀번호를 입력해주세요.">
                    </div>
                    <input type="submit" class="btn_login" value="로그인">
                    <span>* 관리자 전용 로그인 페이지입니다. 게시판과 문자 서비스를 이용하실 수 있습니다. <br />잊어버린 아이디/비밀번호는 문의하시면 안내해 드리겠습니다.</span>
                </form>
            </div>
            <div class="login_notice">
                
            </div>
        </div>
    </div>
    
    <jsp:include page="/Include/Footer.jsp" />
</body>
</html>