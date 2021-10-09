<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.ssafy.application.ApplicationDAO"
	import ="com.ssafy.application.ApplicationDto"
    %>
<%-- 자바 소스 코드 : servlet 참조--%>
<%
		response.setContentType("text/html;charset = utf-8");
		request.setCharacterEncoding("utf-8");
		
		
		//사용자 데이터 꺼내기(parameter)
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String degree = request.getParameter("degree");
		//multiple String받기
		String courses[] = request.getParameterValues("courses");
		String c="";
		if(courses==null) {c="입력하지 않음";
		}else {for(String s : courses) {c+= s+" ";}}
		String choose = request.getParameter("choose");
		if(choose=="선택하세요")choose="";
		String agreement = request.getParameter("agreement");
		
		//데이터베이스에 저장
		
		ApplicationDto app = new ApplicationDto();
		
		app.setName(name==null?"":name);
		app.setPhone(phone==null?"":phone);
		app.setEmail(email==null?"":email);
		app.setDegree(degree==null?"선택안함":degree);//db에 저장
		app.setCourses(c);
		app.setChoose(choose=="unselected"?" ":choose);
		app.setAgreement(agreement==null?" ":"동의");

		ApplicationDAO dao = new ApplicationDAO();
		dao.insertApplicant(app);
		
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입사 지원 완료</title>
<style>
	table,tr,td{
		border:1px solid black;
	}
</style>
</head>
<body>
	<div>
		<table>
			<tr>
				<td>이름</td>
				<td> <%= app.getName() %></td>
			</tr>
			
			<tr>
				<td>핸드폰</td>
				<td ><%= app.getPhone() %> </td>
			</tr>
			<tr>
				<td>이메일</td>
				<td> <%= app.getEmail() %></td>
			</tr>
			<tr>
				<td>학과</td>
				<td>  <%= app.getDegree() %> </td>
			</tr>
			<tr>
				<td>이수과록</td>
				<td ><%= app.getCourses() %></td>
			</tr>
			<tr>
				<td>정보 발송 방법</td>
				<td> <%= app.getChoose() %></td>
			</tr>
			<tr>
				<td>개인정보동의</td>
				<td> <%= app.getAgreement() %></td>
			</tr>
		</table>
	</div>
</body>
</html>
