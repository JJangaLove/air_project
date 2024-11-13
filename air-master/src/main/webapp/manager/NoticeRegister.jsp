<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/Include/Header.jsp" />

 	<div class="register_wrap">
                <div class="header_txt">
                    <h1>공지사항 등록</h1>
                    <h2>먼지 예보의 업데이트 정보 등 다양한 소식들을 알려드립니다.</h2>
                </div>

                <div class="register_cont">
                     <form action="<%= request.getContextPath() %>/insert.notice" method="post">
                        <table class="type1">
                            <colgroup>
                                <col width="20%">
                                <col width="">
                            </colgroup>
                            
                            <tbody>
                                <tr>
                                    <th>제목</th>
                                    <td>
                                        <div class="title"><input type="text" placeholder="제목을 입력하세요." name="title"/></div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>공지사항</th>
                                    <td>
                                        <input type="checkbox" name="isNotice" value="공지사항"/>공지사항
                                        <span class="add_txt">* 순번과 상관없이 최상단에 위치됩니다.</span>
                                    </td>
                                </tr>
                                <tr>
                                    <th>내용</th>
                                    <td>
                                        <textarea class="textarea" name="content"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th>파일첨부</th>
                                    <td>
                                        <input type="file">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="btn_wrap">
                       
                        <input type="submit" value="게시글 등록"></a>
                        </div>
                    </form>
                </div>
            </div>
            
<jsp:include page="/Include/Footer.jsp" />