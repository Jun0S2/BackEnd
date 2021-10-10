<%@page import="board.dao.BoardDAO"%>
<%@page import="board.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
response.setContentType("text/html;charset = utf-8");
request.setCharacterEncoding("utf-8");
	int no = Integer.parseInt(request.getParameter("no"));
	BoardDAO dao = new BoardDAO();
	BoardDto board = dao.selectBoard(no);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
</head>
<body>
	<div>
		<h2>대전 게시판</h2>
		<form action="/Board/boardJSP/modify-process.jsp" method="post">
			<input type="hidden" name="no" value="<%= no %>" />
 			<div>
				<label>제목</label>
				<input type="text" name="title" value="<%= board.getTitle() %>">
			</div>
			<div>
				<label>작성자</label>
<%-- 				<span><%= board.getWriter() %></span> --%>
				<input type="text" name="writer" disabled value="<%= board.getWriter() %>">
			</div>
			<div>
				<textarea name="content" rows="7" cols="80"><%= board.getContent() %></textarea>
			</div>
			<div>
				<button>수정</button>
			</div>
		</form>
	</div>
</body>
</html>
