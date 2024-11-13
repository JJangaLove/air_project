<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>먼지예보</title>
   
  	<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/layout.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/content.css" rel="stylesheet" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    
    <!-- favicon -->
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon03.png">

    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/common.js"></script>
    <script src="${pageContext.request.contextPath}/js/weather.js"></script>
    <script src="${pageContext.request.contextPath}/js/MainNotice.js"></script>
    <script src="${pageContext.request.contextPath}/js/DustMessage.js"></script>
    <script src="${pageContext.request.contextPath}/js/Recommended.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<% String id = (String)session.getAttribute("loginId"); %>
<body>
   <div class="container">
        
        <header id="header">
            <div class="header_cont">
                <h1 class="logo"><a href="${pageContext.request.contextPath}/user/Index.jsp"><img src="${pageContext.request.contextPath}/images/logo02.png"></a></h1>
                <div class="nav-wrap">
                    <nav id="nav">
                        <ul>
                            <li><a href="<%= request.getContextPath() %>/user/Info.do">미세먼지 정보</a></li>
                            <%-- <li><a href="<%= request.getContextPath() %>/user/Index.do">먼지예보</a></li> --%>
                            <li><a href="<%= request.getContextPath() %>/user/Monitoring.do">모니터링</a></li>  
                            <li><a href="<%= request.getContextPath() %>/user/VisualGraph.do">시각화 자료</a></li>  
                            <li><a href="<%= request.getContextPath() %>/user/view.notice">공지사항</a></li>
                            <li><a href="<%= request.getContextPath() %>/user/Message.do">문자서비스</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="utill_wrap">
                	<div class="userId"><% if (id != null) { %><span><%= id %>님</span><% } %></div>
                	
                	<%
						if(id != null){
					%>
                	<button class="btn_logout" type="button" onclick="location.href='/air/user/Logout.jsp';"><i class="fas fa-sign-out-alt"></i></button>
                	<%
						}else{
                	%>
                    <a href="<%= request.getContextPath() %>/Include/Login.do"><button class="btn_manager"><i class="fas fa-user-cog"></i></button></a><%} %>
                    <span class="ballon">관리자</span>
                </div>
            </div>
            <div class="pointer"></div>
        </header>
        
        <div class="inner_wrap">
</body>
</html>