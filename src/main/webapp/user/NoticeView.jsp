<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/Include/Header.jsp" />
<%@ page import="com.air.dao.BoardDTO"%>
<%@ page import="com.air.dao.BoardDAO"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:forEach var="detail" items="${detailList}">
	<div class="notiView_wrap">
		<div class="header_txt">
			<h1>먼지예보 공지사항</h1>
			<h2>미세먼지에 관련된 공지사항과 뉴스를 확인해 보세요.</h2>
		</div>

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
							<div class="title">
								<input type="text" value="${detail.title}" readonly />
							</div>
						</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td><input type="text" value="${detail.id}" readonly /></td>
						<th>등록일</th>
						<td><input type="text" value="${detail.date}" readonly /></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td><input type="file" disabled></td>
						<th>조회수</th>
						<td><input type="text" value="${detail.cnt}" readonly /></td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3"><textarea class="textarea" readonly>${detail.content}</textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btn_wrap">
			<%
				String checkid = (String)session.getAttribute("loginId");
				if(checkid != null){
			%>
				<a href="<%=request.getContextPath()%>/del.notice?num=${detail.num}"
					onclick="return confirm('삭제하시겠습니까?')">
					<button class="btn_notList">삭제</button>
				</a>
				<a href="<%=request.getContextPath()%>/update.notice?num=${detail.num}&title=${detail.title}&content=${detail.content}">
					<button class="btn_notList">수정</button>
				</a>
			<%
			}
			%>
				<a href="<%=request.getContextPath()%>/view.notice">
					<button class="btn_notList">목록으로</button>
				</a>
			</div>
		</div>
	</div>

</c:forEach>
<jsp:include page="/Include/Footer.jsp" />