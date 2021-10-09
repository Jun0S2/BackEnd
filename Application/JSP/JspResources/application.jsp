
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입사지원</title>
	<style type="text/css">
		.container{
			border: 2px solid blue;
			margin: 20px 30px;
			padding: 0 20px 20px;
			width:20%;
		
		}
		.instruction{
			display: block;
		}
		.container-info{
			margin-top:20px;
		}
</style>
</head>
</head>
<body>
<div class="container">
		<h1>입사지원</h1>
		<p>아래 항목을 입력해 주세오</p>
		
		<div class="personal-info">
		<!-- get: queryString shows on address-> use get since its personal info -->
		<form method = "post" action="http://localhost:8080/3반웹보충/applicant-info.jsp">
			<div class="container-info">
				<h4>개인정보:</h4>
				<label for="name">이름</label>
				<input type="text" id = "name" name = "name"/></br>
				<label for="phone">핸드폰</label>
				<input type="text" id="phone" name = "phone"/></br>
				<label for="email">이메일</label>
				<input type="text" id="email" name = "email"/></br>
			</div>
		
				
			<div class="container-info">
				<h4>학과를 선택해주세요<h4>
				<input type = "radio" id = "cpe" value="컴퓨터공학" name = "degree">컴퓨터공학
				<input type = "radio" id = "ee" value="전자과" name = "degree">전자과
				<input type = "radio" id = "math" value="수학과" name = "degree">수학과
				<input type = "radio" id = "ie" value="산업공학과" name = "degree">산업공학과
			</div>		
			
			<div class="container-info">
				<h4>이수 과목은 무엇입니까?<h4>
				<label for="courses"></label>
				<input type = "checkbox" id = "ejb" value="EJB" name = "courses">EJB
				<label for="spring"></label>
				<input type = "checkbox" id = "spring" value="Spring" name = "courses">Spring
				<label for="uml"></label>
				<input type = "checkbox" id = "uml" value="UML" name = "courses">UML
				<br>
				<label for="jdbc"></label>
				<input type = "checkbox" id = "jdbc" value="JDBC" name = "courses">JDBC
				<label for="servlet"></label>
				<input type = "checkbox" id = "servlet" value="Servlet" name = "courses">Servlet
				<label for="jsp"></label>
				<input type = "checkbox" id = "jsp" value="JSP" name = "courses">JSP
			</div>		
		
			<div class="container-info">
			  <p>정보 발송 방법<p>
			  <select name="choose" id="choose">
			    <option value=" "  name = "choose">선택하세요</option>
			    <option value="이메일" name = "choose">이메일</option>
			    <option value="핸드폰" name ="choose">핸드폰</option>
			  </select>
			</div>
			
			
			<div class="container-info">
				<input type="checkbox" id="agreement" name = "agreement" >개인정보약관에 동의합니다
			</div>
			
			<div class="container-info">	
				<input type="submit" value="전송">
			</div>
		
		</form>
		</div>
</div>
</body>
</html>
