# Servlet

자바 서블릿(Java Servlet)은 자바를 사용하여 웹페이지를 동적으로 생성하는 서버측 프로그램이다. 자바 서블릿은 웹 서버의 성능을 향상시키기 위해 사용되는 자바 클래스의 일종이다.

### Project 생성
New>Dynamic Web Project > Apache Tomcat v9.0 > Dynamic web module version 확인
![New Dynamic Web Project Creation](https://images.velog.io/images/junbee/post/12c1e2ea-7fa5-48e7-a9e3-534dbf8f51ca/image.png)

Dynamic web module version 3.0 전후로 차이점이 있는데,

![checkbox](https://images.velog.io/images/junbee/post/4dff2ab9-75ca-44f4-aff6-a793f0128870/image.png)

2버전까지는 반드시 Generate web.xml 체크박스를 선택해야 했지만 3 버전 이후로는 체크하지 않고 annotation으로 대체가 가능하다.

### Code Spcace

![](https://images.velog.io/images/junbee/post/94df3b09-b678-47bd-85bc-d91a84456b8a/image.png)
<div style="width: 60%; float: left">
  Dynamic Web Project를 진행할때는,
<ol>
   <li>Java Resources
   </li>
   <ul>
     <li>src 폴더: Java code</li>
      <li>Libraries: jre library와 tomcat library(servlet-api.jar)</li>
   </ul>
   <li>
   Web Content Folder
   </li>
   <ul>
  <li>Java code 이외의 코드들은 WebContent 폴더 안에 생성한다.
    [Ex | css, html, js, jsp, img 등등 자바 코드를 제외한 모든 resources는 WebContent에 넣는다]</li>
     <li>메타 정보와 웹 정보를 관리하는 META-INF와 WEB-INF파일이 자동 생성되며, JSP파일은 여기 하위에 저장되어야 경로를 찾을 수 있다. </li>
   </ul>
  </ol>
</div>
</div>
<div style="clear:both;"></div>

참고로, 클라이언트가 http://localhost:port#/root경로/를 요청하게 되면 index.html을 가장 우선적으로 찾아 불러온다. 즉, http://localhost:port#/root경로/index.html을 불러오게 된다.
톰갯은 index.html, index.htm, index.jsp 순서대로 페이지를 찾기 때문이다.

![](https://images.velog.io/images/junbee/post/d1e731f5-5d5e-483b-bb66-2d9984a34526/%EC%83%88%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8%20(4).png)
                                                                                           


### Servlet의 Life Cycle
1. #### 🔨init() 
init()은 초기화하는 작업으로 최초 한번만 실행된다.
2. #### 🔨service() 
Service()는 요청과 응답을 처리하는 작업으로, 요청시마다 실행한다.
또한, 파라미터에 request 와 response를 지닌다.
> Parameter 전송 방식에는 Get 방식과 Post 방식이 있다.
**Get 방식** 
url뒤에 queryString으로 전달되기 때문에, 글자수의 제한이 있고 url에 노출이 된다. 
즉, 길거나 보안이 필요한 정보는 Post방식을 사용해야 한다.
**Post 방식**
request body에 담겨져 데이터로 전달된다


3. #### 🔨destroy()
자원을 반납하는 작업으로 끝날 때 실행된다.
<br>

### Servlet
![](https://images.velog.io/images/junbee/post/c28bd8bb-fdae-4afd-aa37-499d8dcf678f/image.png)
   <figcaption align="center">이미지 출처 : https://codedec.com/tutorials/genericservlet-class-in-servlet/</figcaption>

#### 📌Servlet
아래는 Servlet의 가장 기본적인 구조이다. 
Servlet을 사용하기 위해서는, 해당 클래스가 Servlet type이어야 한다. 즉, Servlet Interface를 구현해야 한다. 이때, destroy, getServletConfig, getServletInfo, init, service를 재정의 해야한다.

```java
import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class TestServlet implements Servlet {
	@Override
	public void destroy() {}
	@Override
	public ServletConfig getServletConfig() {return null;}
	@Override
	public String getServletInfo() {return null;}
	@Override
	public void init(ServletConfig config) throws ServletException {}

	@Override
	public void service(ServletRequest req, ServletResponse res) 
    	throws ServletException, IOException {
		System.out.println("code");
	}
}


```
#### 📌Generic Servlet
위에서 구현한 servlet은 override해야하는 메서드들이 꽤 많다. 따라서, Generic Servlet이 등장하였다. GenericServlet을 상속받지만, 여전히 service 메서드를 재정의 해야한다. 
하지만, 웹에서는 service method가 필요 없는 경우가 있다. Generic Servlet을 사용하면, Get이나 Post 방식을 사용해야 하는 경우에는 if문을 주어서 구분하여 사용해야한다.
```java
import java.io.IOException;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class TestGenericServlet extends GenericServlet {
	@Override
	public void service(ServletRequest req, ServletResponse res) 
    	throws ServletException, IOException {
		System.out.println("code");
	}
}

```
#### 📌Http Servlet
Http Servlet은 추상 클래스가 없다 (의미상의 추상클래스). 즉, HttpServlet을 상속받게되면 아무 메서드도 재정의하지 않아도 된다. 하지만, 아무런 메서드를 정의하지 않으면 405 에러가 발생하게 된다.
Http Servlet을 사용하여, doGet이나 doPost 메서드 또는 둘다를 재정의하여 용도에 맞게 사용할 수 있다.
```java
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/main")
public class TestHttpServlet extends HttpServlet {
	//아무 메서드도 정의하지 않으면 "지원하지 않는 방식이라는 405 에러 발생한다."
	//doGet이나 doPost를 사용할 수 있다.    
}
```

### URL Mapping
![](https://images.velog.io/images/junbee/post/a4897ac0-ef12-4484-8124-11d18010c75f/%EC%83%88%20%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8%20(2).png)

>#### Method 1

**Context Root**를 설정하지 않으면, 프로젝트 명이 default로 root의 이름이 된다. 이는 path이기 때문에, 위의 이미지의 세번째 단계에서 context root에 원하는 path명을 주면, url이 설정한 path로 잡힌다.

#### Step 1: 프로젝트 생성
![](https://images.velog.io/images/junbee/post/a7c65ef9-e036-4e6e-8ad7-808c33a9cd2b/image.png)
#### Step 2: Context Root의 path를 변경
![](https://images.velog.io/images/junbee/post/f6f93786-9f5f-4dd1-9db9-82aeb82af177/image.png)
#### Step 3: 코드 작성
>Html 코드
```html
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello Servlet</title>
</head>
<body>
	<h1>Check the Address!</h1>
	<form method="post" action="temp/new-root">
		<input type="text" name="msg">
		<button>check it out</button>
	</form>
</body>
</html>
```

#### Step 4: Tomcat 실행 및 주소 확인
![](https://images.velog.io/images/junbee/post/b80e659f-61b0-4371-a7e2-fbfedb55dce1/image.png)

>#### Method 2: Annotation
**Anotation**을 사용하여 url을 mapping 할 수도 있다.
#### Step 1: 프로젝트 생성 
위와 같은 과정으로 프로젝트를 생성하나 **[[Step 2]]** 는 생략하고 finish를 누른다.

#### Step 2: Servlet 생성
test 파일을 생성하고 **annotation**을 통해 url을 맵핑해준다.

> **Annotation**사용 방법
Format: @WebServlet("/주소")<br>
자바 소스 코드
```java
package temp;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
@WebServlet("/temp/update")
public class test extends GenericServlet{
	@Override
	public void service(ServletRequest req, ServletResponse res)
    	throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		out.println("<h1> Hello, there!</h1>");
		out.close();
	}
}
```

#### Step 3: Tomcat 실행 및 주소 확인
![](https://images.velog.io/images/junbee/post/237d5881-e143-4920-92eb-ee26640be668/image.png)
@WebServlet("/temp/update")로 맵핑했기 때문에, 위의 캡쳐본을 보면 pjt/temp/temp로 제대로 맵핑이 된 것을 확인할 수 있다.
