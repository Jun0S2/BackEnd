<%@ page language="java" contentType="text/html; 
charset=UTF-8"
import = "board.dao.BoardDAO"
%>
<%
	//삭제하려면 dao 랑 삭제할 게시글 번호가 필요함
	//request.getParameter("no");
	BoardDAO dao = new BoardDAO();
	dao.deleteBoard(Integer.parseInt(request.getParameter("no")));
	//자동으로 메인 리스트로 돌아가야함->script사용

%>

<script type="text/javascript">
	location.href = "/Board/boardJSP/list.jsp";
</script>
