# JSP 기본 지식


**Java Server Page (자바 서버 페이지, JSP)는 HTML내에 자바 코드를 삽입하여 웹 서버에서 동적으로 웹 페이지를 생성하여 웹 브라우저에 돌려주는 서버 사이드 스크립트 언어이다**

## Why?

Servlet 만으로 웹사이트를 제작하려면 print.out으로 html구조를 자바 클래스 안에서 작성해야 하는데 이는 매우 번거롭고 가독성도 떨어진다. 아래는 서블릿을 통해, 사용자가 입력한 정보를 화면에 출력하는 코드이다. 
아래는 간단한 테이블로 작성했음에도 불구하고 작성자는 테그와 글자 사이의 +와 줄띄우기 등등으로 수많은 오류와 디버깅을 해야했다. 하지만 이것보다 구조가 어려워진다면 어떻게 될까?

>
```java
	//사용자에게 결과 응답
	PrintWriter out = response.getWriter();
	//out.println();
	out.println("<table border=\"1\" style=\"border:1px solid\"> " + 
		"	<tr>\r\n" + 
		"		<td>이름</td>\r\n" + 
		"		<td>"+app.getAgreement()+"</td>\r\n" + 
		"	</tr>\r\n" + 
		"	<tr>\r\n" + 
		"		<td>핸드폰</td>\r\n" + 
		"		<td>"+app.getPhone()+"</td>\r\n" + 
		"	</tr>\r\n" + 
		"	<tr>\r\n" + 
		"		<td>이메일</td>\r\n" + 
		"		<td>"+app.getEmail()+"</td>\r\n" + 
		"	</tr>\r\n" + 
		"	<tr>\r\n" + 
		"		<td>학과</td>\r\n" + 
		"		<td>"+app.getDegree()+"</td>\r\n" + 
		"	</tr>\r\n" + 
		"	<tr>\r\n" + 
		"		<td>이수과목</td>\r\n" + 
		"		<td>"+app.getCourses()+"</td>\r\n" + 
		"	</tr>\r\n" + 
		"	<tr>\r\n" + 
		"		<td>정보 발송 방법</td>\r\n" + 
		"		<td>"+app.getChoose()+"</td>\r\n" + 
		"	</tr>\r\n" + 
		"	<tr>\r\n" + 
		"		<td>개인정보동의</td>\r\n" + 
		"		<td>"+app.getAgreement()+"</td>\r\n" + 
		"	</tr>\r\n" + 
		"</table>\r\n" 
		);
	out.close();
 }
```

JSP는 이러한 문제점을 해결해준다.
아래는 jsp로 작성한 코드로 위와 동일한 기능을 한다

>
```jsp
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
```

가독성이 훨씬 뛰어나짐을 느낄 수 있을 것이다.
<p align = "center">
  <img src = "https://images.velog.io/images/junbee/post/141e61ac-577e-4274-8e8f-bc9be3e5ae7f/wow.gif">
</p>
JSP는 자바 코드를 <% %> 구조를 사용하여 출력 화면에 필요한 연산이나 프로그램을 작성하고, HTML 코드를 사용하여 간단히 출력할 수 있도록 도와준다. 


## How it Works?
JSP로 작성된 프로그램은 서버로 요청시 서블릿 파일로 변환되어 JSP 태그를 분해하고 추출되어 다시 순수한 HTML 이 되어 해석된다. 
<p align="center">
	<img src = "https://images.velog.io/images/junbee/post/21fea9d8-e3ad-4634-b187-e5b170db779a/image.png"><br>
	이미지 출처: https://slidetodoc.com/cs-3220-web-and-internet-programming-introduction-to-5/
</p>



위 그림을 보면, JSP가 서블릿으로 변환되어 서버로 전송되고, HTML 코드만 브라우저에 의해 프로세스 되는 것을 볼 수 있다. 
> 참고로, 구글에 translate jsp to servlet을 검색하면 다양한 사이트들이 나오는데 좀 더 공부하고 싶다면 한번 검색해 보는 것을 추천한다. 

## How to Use ?
### 자바 코드 작성하기
JSP 를 사용하여 자바 코드를 작성하기 위해서는 우선 스크립팅 요소를 알아야 한다. 아래 스크립팅 요소를 통하여, 필요한 자바 코드를 html과 함께 사용할 수 있다.
> **Scripting Element(스크립팅 요소)**
JSP 내부에서 scripting element를 사용하여 _"이 부분이 자바코드야!"_ 하고 알려주는 테그이다
1. Declare (선언)
```jsp
<%! 맴버 변수와 메서드 작성 %>
Example: 
<%! 
	int count= 10; //맴버 변수 선언
	public void countDown(){ count--; } //메서드 작성
%>
```
2. Scriplet (스크립트릿)
```jsp
<% java code를 처리해 준다. %>
Example: 
<%
	for(int i = 0 ; i< 10 ; i++) { out.println("i"); } //i를 출력하는 자바 코드
%>
```
3. Expression (표현식)
```jsp
<%= 문자열  %> : [주의!] ; 을 찍으면 안돼니 주의하자. 출력할 때 사용
Example
<%! String name = "June Park"; %>
<h1> Hello, World! </h1>
<h3> My Name is <%= name %>!</h3>
```
4. Comments (주석)
```jsp
<%-- comments goes here --%>
[note] jsp 의 주석은 개발자 모드로 봐도 찍히지 않는 걸 볼 수 있다.
```

<hr>

### 1. Import Statements
자바로 프로그램을 작성 할 때, 리스트나 배열 혹은 다른 클래스를 import 하게 되는데, jsp도 마찬가지 이다. jsp에서 import 할 때에는 <%@ page import="~~~"%> 를 사용한다.

> #### ERROR !
```jsp
<% 
import java.util.*;//잘못된 import statement -> error 발생
List<Integer> list = new ArrayList<>();
%>
```
#### CORRECT !
```jsp
<%@ page import = "java.util.*, packageName.*." %> //콤마를 사용하여 다중 import 가능
<% List<Integer> list = new ArrayList<>(); %>
```

### 2. 내장 객체
내장 객체는 선언문 없이도 사용 가능한, "내장된" 객체들이다. 
JSP에는 총 9가지 내장 객체가 있다 (8가지 + exception)
* `request` : client 의 http 요청 정보를 저장
* `response` : http요청에 응답할 정보를 저장
* `pageContext` : 응답 페이지 실행에 필요한 context 정보 저장
* `Session` : client가 서버를 접속했을 때 세션 정보를 저장
* `Application` : 해당 application의 context 정보 저장
* `config` : 특정 페이지의 서블릿 설정 정보를 저장 
* `out` : 응답 페이지 전송을 위한 출력
* `page` : 특정 페이지의 서블릿 객체
* `Exception` :예외 처리

내장 객체들은 이미 reserved 되었기 때문에, 내장 객체와 같은 이름을 지닌 객체를 생성하면 안된다 ! 
