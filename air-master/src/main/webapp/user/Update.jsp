<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/Include/Header.jsp" />
<%@ page import="com.air.dao.BoardDTO"%>
<%@ page import="com.air.dao.BoardDAO"%>

<div class="notiView_wrap">
    <div class="header_txt">
        <h1>먼지예보 공지사항 - 수정</h1>
        <h2>미세먼지에 관련된 공지사항과 뉴스를 확인해 보세요.</h2>
    </div>

            <form action="<%=request.getContextPath()%>/update.notice" method="post">
    <div class="notiView_cont">
        <table class="type1">
            <colgroup>
                <col width="20%">
                <col width="">
            </colgroup>
            <tbody>
                <tr>
                    <th>제목</th>
                    <td colspan="3">
                        <input type="text" name="title" value="${detail.title}" />
                    </td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>
                        <input type="text" value="${detail.id}" readonly/>
                    </td>
                    <th>등록일</th>
                    <td>
                        <input type="text" value="${detail.date}" readonly/>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        <input type="file" disabled>
                    </td>
                    <th>조회수</th>
                    <td>
                        <input type="text" value="${detail.cnt}" readonly/>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3">
                        <textarea name="content" class="textarea">${detail.content}</textarea>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="btn_wrap">
                <input type="hidden" name="num" value="${detail.num}">
                <button type="submit" class="btn_notList">수정 완료</button>
        </div>
    </div>
</div>
            </form>

<jsp:include page="/Include/Footer.jsp" />