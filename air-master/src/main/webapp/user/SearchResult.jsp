<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 결과</title>
</head> -->
<style>
    .no-result-message {
        text-align: center;
        font-weight: bold; 
    }
     .notice_title:hover {
            font-weight: bold; 
            cursor: pointer;
        }
</style>
    <jsp:include page="/Include/Header.jsp" />
<body>

    <div class="notice_wrap">
        <div class="header_txt">
            <h1>먼지예보 검색 결과</h1>
        </div>

		<div class="no-result-message">
        <c:if test="${empty searchResult}">
            <div>${message}</div>
        </c:if>
        </div>
        

        <c:if test="${not empty searchResult}">
            <div class="notice_cont">
                <table class="type1">
                    <colgroup>
                        <col width="15%">
                        <col width="">
                        <col width="25%">
                        <col width="10%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>게시글번호</th>
                            <th>제목</th>
                            <th>날짜</th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="post" items="${searchResult}">
                            <tr>
                                <td class="center">${post.num}</td>
                                <td class="left"><a href="detail.notice?num=${post.num}" class="notice_title">${post.title}</a></td>
                              
                                <td class="center">${post.date}</td>
                                <td class="center">${post.cnt}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="btn_wrap">
                <a href="<%=request.getContextPath()%>/manager/NoticeRegister.do">
                    <button class="btn_register">게시글 작성</button>
                </a>
            </div>
        </c:if>
    </div>

    <jsp:include page="/Include/Footer.jsp" />
</body>
</html>