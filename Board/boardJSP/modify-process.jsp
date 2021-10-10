<%@page import="board.dto.BoardDto"%>
<%@page import="board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//수정할 게시글 번호:
	response.setContentType("text/html;charset = utf-8");
	request.setCharacterEncoding("utf-8");
	int no = Integer.parseInt(request.getParameter("no"));
	BoardDAO dao = new BoardDAO();//database
	BoardDto board = dao.selectBoard(no);//get previous board info
	
	//Get parameters that modify.jsp sent
	String newTitle = request.getParameter("title");
	String newContent = request.getParameter("content");
	
	//set new data
	board.setContent(newContent);//새로운 content로 세팅
	board.setTitle(newTitle);
	
	//update database
	dao.updateBoard(board);
 %>
  <script>
  location.href = "/Board/boardJSP/detail.jsp?no=<%=board.getNo()%>";
  //다시 수정한 게시글로 돌아간다
  </script>
