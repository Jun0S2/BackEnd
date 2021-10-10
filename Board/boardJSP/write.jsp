<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
<body>
	<div>
		<h2>대전 3반 이야기</h2>
		
		<form action = "/Board/boardJSP/write-process.jsp" method = "post">
			<div>
				<label>제목</label>
				<input type = "text" name = "title">
			</div>
			<div>
				<label>작성자</label>
				<input type = "text" name = "writer">
			</div>
			<div>
				<!-- 7줄, 한줄당 80자 -->
				<textarea rows = "7" cols = "80" name = "content"></textarea>
			</div>
			<!-- Submit Button -->
			<button>등록</button>
		</div>
		</form>
</body>
</html>
