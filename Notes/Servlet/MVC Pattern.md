# Servlet, JSP, and MVC Pattern

>Previously....
1. Servlet으로 DB 접근 & 화면 출력 -> 화면단 만들기가 어려웠음
2. JSP로 DB접근 & 화면 출력 -> 화면단 만들기는 쉬우나 자바코드와 섞이기 때문에 복잡해진다. 예전엔느 실무에서 코드가 한 jsp 파일 당 2~ 3천자정도 되었다고...

MVC 패턴은 위의 문제점들을 해결하기 위한 패턴 구조이다. 
MVC 페턴은, Servlet이 logic 처리를 하고, jsp는 화면단만 처리한다.

Servlet, JSP, MVC 구조를 살펴보기 위해 간단한 봉사활동 참가 희망자 지원 웹사이트를 제작하였다.

| 입력 화면 | 출력 화면|
|:----------:|:----------:|
|![](https://images.velog.io/images/junbee/post/14197426-481d-4906-bc6b-05a4148be8f0/image.png) | ![](https://images.velog.io/images/junbee/post/96a485d9-5bd6-4328-83f7-9c6c93f8552a/image.png)




## 1. Servlet
기본적인 Servlet으로 위의 화면을 만들기 위해서는 html파일과 Servlet 파일이 필요하다.
**데이터를 받는 화면을 html로 설계 -> 데이터를 받아서 무언가를 하는 작업이 필요한 화면은 Servlet으로 작성하는 방식이다. **

>### HTML: application.html
html코드에서 중요시할점은, form의 method 와 action이다.
위 예시에서는, html파일로 입력받은 내용을 출력해야하기 때문에 post 방식을 사용하여 Servlet으로 보내주었다. 
** root: StudyMaterials, servlet의 webservlet path를 /service/applied로 지정한 상황
[참고로, CSS파일은 WEB-INF안에 넣는게 아니라 WebContent안에 넣어야한다.]
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Service Application Form</title>
<link rel="stylesheet" href="css/index.css" type="text/css">
</head>
<body>
<div class = "container">
		<h1>대전 중학교 봉사활동 지원 신청</h1>
		<form method ="post" action="/StudyMaterials/service/applied"> 
				<div class="input">
					<label for = "student_name">이름</label>
					<input type="text" name="student_name">
		<!-- 기타 입력 form 생략 -->
		<button type = "submit">확인</button>		
	</form>	
</div>
</body>
</html>
```

>### Servlet: AppliedServlet.java
Servlet에서는 html에서 넘겨준 정보를 받아서, Dto에 넣어 저장해준다. 이번 예시에서는 데이터베이스와 연결을 하지 않았기 때문에 DAO를 사용하지 않았다.
```java
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dto.CommunityServiceDto;
@WebServlet("/service/applied")/*  /service/applied로 오는 애들을 처리해준다! */
public class AppliedServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    		//한글 안꺠지도록 설정
		response.setContentType("text/html;charset = utf-8");
		request.setCharacterEncoding("utf-8");
        	//html에서 받은 내용은 getParameter("html상의 name")으로 받는다
		String name = request.getParameter("student_name");
		int grader = Integer.parseInt(request.getParameter("student_year"));
		String volunteer = request.getParameter("volunteer");
		String date = request.getParameter("date");
		//객체에 담아서 저장한다
		CommunityServiceDto info = new CommunityServiceDto(name, grader, volunteer, date);
		//화면에 출력
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>\r\n" + 
				"<html>\r\n" + 
				"<head>\r\n" + 
				"<meta charset=\"UTF-8\">\r\n" + 
				"<title>지원 완료</title>\r\n" + 
				"<link rel=\"stylesheet\" href=\"../css/index.css\" type=\"text/css\">\r\n" + 
				"</head>\r\n" + 
				"<body>\r\n" + 
				"    <div class= \"container\">\r\n" + 
				"        <h1>지원 완료</h1>\r\n" + 
				"            <p >지원해주셔서 감사합니다 ^-^</p>\r\n" + 
				"           <img src = \"../images/thank-you-for-volunteering-appreciate-you.gif\">\r\n" + 
				"            <hr>\r\n" + 
				"            <h2>"+info.getVolunteer()+" </h2>\r\n" + 
				"            <div class=\"inner\">\r\n" + 
				"                <h3>이름</h3>\r\n" + 
				"                <div class=\"text\"> "+info.getName()+" </div>\r\n" + 
				"\r\n" + 
				"                <h3>학년</h3>\r\n" + 
				"                <div class=\"text\"> "+info.getGrader()+" </div>\r\n" + 
				"\r\n" + 
				"                <h3>봉사활동 종목</h3>\r\n" + 
				"                <div class=\"text\">" +info.getVolunteer()+ "</div>\r\n" + 
				"\r\n" + 
				"                <h3>선택 날짜</h3>\r\n" + 
				"                <div class=\"text\">"+info.getDate()+"</div>\r\n" + 
				"\r\n" + 
				"            </div>\r\n" + 
				"\r\n" + 
				"    </div>\r\n" + 
				"    \r\n" + 
				"</body>\r\n" + 
				"</html>");
	}
}
```

Servlet은 화면 출력이 매우 불편함을 볼 수 있다.
데이터를 수정하려면 +와 " 의 행렬에 머리가 아프다.

## 2. JSP
위 웹사이트를 JSP만을 통해서 제작하기 위해선 입력창.jsp와 출력화면.jsp 두개의 파일이 있으면 된다. 
>### 입력: application.jsp 
html에서와 마찬가지로 method와 action에 신경써준다. action에는 출력.jsp의 주소를 입력해주면 submit 버튼을 눌렀을 때 출력.jsp화면으로 다이렉트 된다.
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 내용 생략 %-->
<div class = "container">
		<h1>대전 중학교 봉사활동 지원 신청</h1>
		<form method ="post" action="/StudyMaterials/jsp/applied.jsp"> 
		<!-- 내용 생략-->
		<button type = "submit">확인</button>			
	</form>	
</div>
</body>
</html>
```

>### 츨력: applied.jsp
출력하는 jsp, 즉 정보를 받은 jsp에서는 Servlet구조에서의 Post 메서드를 <% %> 를 이용하여 따로 자바 코드를 빼주면 된다.
아래 화면처럼, <%자바코드%>안에 서블릿때의 코드를 동일하게 넣은 것을 발견할 수 있다.
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "dto.CommunityServiceDto"%>
<%		<%--서블릿 코드와 동일 --%>
    	response.setContentType("text/html;charset = utf-8");
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("student_name");
	int grader = Integer.parseInt(request.getParameter("student_year"));
	String volunteer = request.getParameter("volunteer");
	String date = request.getParameter("date");
	CommunityServiceDto info = new CommunityServiceDto(name, grader, volunteer, date);
%>
```
jsp 파일의 html부분에는 위에서 작성한 자바 파일을 활용하여 html과 java를 조합하여 사용한다.
```jsp
<!--JSP 활용 -->
<h3>이름</h3>
 <div class="text"> <%= info.getName() %> </div>
```
Servlet의 화면 출력단과 비교해보면 출력단이 한결 간결해진것을 확인해 볼 수 있다.
```java
// Servlet 내의 out.println()을 사용하는 출력문
 <h3>이름</h3>\r\n" + 
 "<div class=\"text\"> "+info.getName()+" </div>\r\n" + 
"\r\n" + ...생략
```

## 3. MVC Pattern
MVC Pattern은 Servlet과 JSP를 둘 다 활용하는 방식이다. JSP 역시 위의 간단한 출력 화면에서는 쉽게 사용했지만 실무에서 쓰기엔 자바 코드가 너무 많아지기 때문에 디버깅이 어려워진다. 

> 따라서, **JSP의 자바 코드는 Servlet에서  작성하고, 화면만 JSP 를 통해 작성한다.**  
서블릿에서는 화면에서 입력받은 내용을 저장하고, setattribute로 request영역에 자원을 공유한다. servlet은 redirect나 forward를 사용하여 jsp를 호출하고, 호출된 jsp에서는 서블릿이 공유한 자원을 getattribute로 공유받을 수 있다.

아래 예시는, 메인 페이지에서(jsp)-> Servlet으로 정보를 전달 -> jsp를 호출하여 화면단 출력하는 구조이다.

> ### ApplicationServlet.java
```java
//import문 생략
@WebServlet("/mvc/applied")//applied로 오는 애들을 처리한다.
public class AppliedServlet2 extends HttpServlet{
	//do post만 온다
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");
		//Get Parameters
		String student_name = req.getParameter("student_name");
		int student_year = Integer.parseInt(req.getParameter("student_year"));
		String volunteer = req.getParameter("volunteer");
		String date = req.getParameter("date");
		//객체를 만들어서 위 정보를 담는다
		CommunityServiceDto info = new CommunityServiceDto(student_name,student_year, volunteer,date);
		req.setAttribute("info", info);	
		//페이지가 applied에 머물러야하기 때문에 forward사용
		String path = "/MVC/mvc-applied.jsp";
		RequestDispatcher rd  = req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
}
```

>### applied.jsp
JSP 코드 영역
```java
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "dto.CommunityServiceDto"%>
<%
//MVC 구조: Servlet에서 담은 정보(set attribute)를 get attribute으로 접근
 	CommunityServiceDto info = (CommunityServiceDto) request.getAttribute("info");
%>
```
HTML 코드 영역
```
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Applied Successfully</title>
<link rel="stylesheet" href="../css/result-page.css" type="text/css">
</head>
<body>
    <div class= "container">
        <h1>지원 완료</h1>
            <hr>
            <h2><%=info.getVolunteer() %> </h2>
            <div class="inner">
                <h3>이름</h3>
                <div class="text"> <%= info.getName() %> </div>
				... 내용 생략 ...
            </div>
    </div>
</body>
</html>
```

### Redirect 와 forward
MVC 패턴에서 중요한 것은, forward와 redirect라고 생각한다. 

**만일, url이 현재 페이지와 동일해야한다면 forward,그렇지 않다면 redirect를 사용한다.**

위의 예시는 servlet의 path는 /applied로 지정했다. 
메인 화면이 아래 서블릿을 호출하였고 아래 서블릿이 applied.jsp에 메인에서 받은 정보를 알려주는 형식이기 때문에 redirect를 쓰면 url이 바뀌기 때문에 주소가 /mvc/main -> /mvc/applied -> /mvc/applied.jsp가 된다. 
따라서, forward를 써주어야 url의 변동 없이 /mvc/applied에서 화면단이 보이게 된다.
