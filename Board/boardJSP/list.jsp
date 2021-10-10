<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "board.dao.BoardDAO, board.dto.BoardDto" %> 
<%
	BoardDAO dao = new BoardDAO();
	List<BoardDto> list = dao.selectAllBoard();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대전 게시판</title>
</head>
<body>
	<div>
	<h2>대전 게시판</h2>
		<table>
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>글쓴이</td>
				<td>조회수</td>
			</tr>
			<%
				for(BoardDto board:list){
			%>
			<tr>
				<td><%= board.getNo()%></td>
				<td><a href = "/Board/boardJSP/detail.jsp?no=<%=board.getNo() %>" ><%= board.getTitle() %></a></td>
				<td><%= board.getWriter() %></td>
				<td><%= board.getViewCnt() %></td>
			</tr>
			<%
				}
				if(list.isEmpty()){
			%>
				<td colspan = "4"> 게시글이 존재하지 않습니다.</td>
			<%
			
				}
			%>
		</table>
	<div>
		<a href="/Board/boardJSP/write.jsp">글쓰기</a>	
	</div>
	</div>

</body>
</html>
