<%@ page import="com.air.dao.BoardDTO"%>
<%@ page import="com.air.dao.BoardDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- String user_id = (String) session.getAttribute("login"); -->
<%
String keyword = request.getParameter("keyword");
BoardDAO dao = new BoardDAO();
List<BoardDTO> list = dao.selectBoard();
if (keyword != null && !keyword.isEmpty()) {
	list = dao.searchBoard(keyword);
} else {
	list = dao.selectBoard();
}
%>
<jsp:include page="/Include/Header.jsp" />

<div class="notice_wrap">
	<div class="header_txt">
		<h1>먼지예보 공지사항</h1>
		<h2>미세먼지에 관련된 공지사항과 뉴스를 확인해 보세요.</h2>
	</div>

	<div class="notice_cont">

		<div class="search_wrap">
			<form action="${pageContext.request.contextPath}/search.notice"
				method="GET">
				<input type="text" class="search" name="keyword"
					placeholder="검색어를 입력하세요." />
				<button type="submit" class="search_btn">
					<img src="${pageContext.request.contextPath}/images/ico_search.png"
						alt="검색하기" />
					<!--  <i class="fas fa-search"></i> -->
				</button>
			</form>
		</div>

		<!-- <div class="search_wrap">
			<input type="text" class="search" placeholder="검색어를 입력하세요." />
			<button class="search_btn">
				<img src="../images/ico_search.png" alt="검색" />
				<i class="fas fa-search"></i>
			</button>
		</div> -->
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
				<%-- 
				<tr>
					<td>1</td>
					<td><a href="<%=request.getContextPath()%>/user/NoticeView.do">
							<span class="n_badge">공지사항</span>
							<p>안녕하세요. 먼지예보입니다 Lorem ipsum dolor sit amet consectetur
								</p>
					</a></td>
					<td>2024.04.12 11:29</td>
					<td>11</td>
				</tr> --%>



				<c:forEach var="post" items="${list}" begin="${start}" end="${end}">
					<tr>
						<td>${post.num}</td>
						<td><a
							href="${pageContext.request.contextPath}/detail.notice?num=${post.num}"
							class="notice_title">${post.title}</a></td>
						<td>${post.date}</td>
						<td>${post.cnt}</td>

					</tr>
				</c:forEach>

			</tbody>
		</table>

		<%--    <li>
             <a href="${pageUrl}" class="${paging == currentPage ? 'active' : ''}">
             <c:choose>
              <c:when test="${paging == currentPage}">
            	    <strong>${paging}</strong>
           	   </c:when>
              <c:otherwise>${paging} </c:otherwise>
       		 </c:choose>
  		   </a>
			</li>
			 --%>




		<div class="pagination">
			<ul>
				<c:if test="${startPage > 1}">
					<a href="/view.notice?pageNum=${startPage - 1}" class="page-link">
						<i class="fas fa-caret-left"></i>
					</a>
				</c:if>
				<c:forEach var="paging" begin="${startPage}" end="${endPage}">
					<c:url value="/view.notice" var="pageUrl">
						<c:param name="pageNum" value="${paging}" />
					</c:url>
					<li> <a href="${pageUrl}" class="${paging == currentPage ? 'active' : 'page-link'}">
					<c:choose>
								<c:when test="${paging == currentPage}">
									<strong>${paging}</strong>
								</c:when>
								<c:otherwise>${paging} </c:otherwise>
							</c:choose>
					</a></li>

				</c:forEach>
				<c:if test="${endPage < pageSize}">
					<a href="/view.notice?pageNum=${endPage + 1}" class="page-link">
						<i class="fas fa-caret-right"></i>
					</a>
				</c:if>
			</ul>
		</div>
		<%
			String checkid = (String)session.getAttribute("loginId");
			if(checkid != null){
		%>
		<div class="btn_wrap">
			<a href="<%=request.getContextPath()%>/manager/NoticeRegister.do">
				<button class="btn_register">게시글 작성</button>
			</a>
		</div>
		<%
			}
		%>
	</div>
</div>
</form>

<jsp:include page="/Include/Footer.jsp" />