<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%--글번호에 해당하는 게시글 정보 보여주기 --%>
<%@ page import = "board.dao.BoardDAO, board.dto.BoardDto" %> 

<%
	 int no = Integer.parseInt(request.getParameter("no"));//no를 파라미터에 넘겨받음
	 BoardDAO dao = new BoardDAO();
	 //dao는 모든 데이터를 가졋어. 즉, 8번 게시글을 보고싶다면 하나만 선택해야해!
	 //또, 하나만 선택한 객체를 담으려면 boardDto도 필요해
	 BoardDto board = dao.selectBoard(no);
	 dao.increaseView(board.getViewCnt(), no);
	
	
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 보기</title>
<link rel = "stylesheet" href= "/WebContent/boardCSS/detail.css">
</head>
<body>
<div class="container">
	<h2>제목: <%= board.getTitle() %></h2>
	<div>
		<label>작성자</label>
		<span><%= board.getWriter() %></span>
		
	</div>
	<div>
		<label>내용</label>
		<span><%= board.getContent() %></span>
	</div>
	
	<div>
		<label>조회수</label>
		<span><%= board.getViewCnt()+1 %></span>
	</div>
	
	<!-- 돌아가는 버튼이랑 수정 버튼 필요하지 않을까? -->
	<a href = "/Board/boardJSP/list.jsp">목록</a>
	<a href = "/Board/boardJSP/modify.jsp?no=<%=board.getNo()%>">수정</a>
	<a href = "/Board/boardJSP/delete-process.jsp?no=<%=board.getNo()%>">삭제</a>
</div>


</body>
</html>
	<a href = "/Board/boardJSP/modify.jsp?no=<%=board.getNo()%>">수정</a>
	<a href = "/Board/boardJSP/delete-process.jsp?no=<%=board.getNo()%>">삭제</a>
</div>


</body>
</html>
