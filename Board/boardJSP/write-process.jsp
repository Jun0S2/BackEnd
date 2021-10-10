<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "board.dto.BoardDto" %>
<%@ page import = "board.dao.BoardDAO" %>
 <%-- Write Process는 화면이 아니라, 게시글 작성 등록을 도와주는 애임 . 따라서 html코드는 필요 없다--%>
<%
	request.setCharacterEncoding("utf-8");
	//Get Data
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	
	//꺼낸 값을 DAO한테 줘야함. 이 전에 주기 전에 따로따로 세개를 주는게 아니라
	//Dto를 통해서 먼저 넘긴 후 dto객체를dao한테 넘긴다
	
	//2. Board Dto에 저장->import
	BoardDto board = new BoardDto();
	board.setTitle(title);
	board.setWriter(writer);
	board.setContent(content);
	
	//3.DAO에 저장
	BoardDAO dao = new BoardDAO();
	dao.insertBoard(board);
	//4.-등록을 했으니까 전체 목록에 추가해줘야 한다 -> location.href를 줘서 자동으로 목록 로드 -
%>

<script type="text/javascript">

	location.href ="/Board/boardJSP/list.jsp";

	
</script>
