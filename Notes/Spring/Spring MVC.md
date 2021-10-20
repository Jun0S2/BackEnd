# Spring MVC
스프링을 이용한 mvc
실무에서 가장 많이 사용할 파트 


>## Previously...
# MVC Pattern
|  장점 | 단점  |
|:---:|:---:|
| 화면과 비즈니스 로직 분업 가능  | 개발 과정이 복잡하여 초기 개발속도가 느림  | 
| 영역별 개발로 확장성이 뛰어남  | 초보자가 이해하고 개발하기 다소 어려움  |  
| 표준화된 코드를 사용하여 공동작업에 유리 |   |
| 유지보수에 좋음 |
### Model
* 어플리케이션 상태의 캡슐화
* 상태 쿼리에 대한 응답
* 어플리케이션의 기능 표현
* 변경을 view 에 통지
### View
* literally view
* 모델에게 업데이트 요청
* 사용자 input을 컨트롤러에게 전달
* 컨트롤러는 view를 선택하여 결과 페이지나 응답 페이지를 보여줌
### Controller
* 사용자 액션과 모델을 맵핑해줌
* 응답에 대한 view를 선택



# Spring MVC
<p align = "center">
<img src  = "https://user-images.githubusercontent.com/36508552/138025620-4e20d1d8-4e5b-40ee-b892-eceaa66a465f.PNG">
</p>

## 특징
* Spring은 DI 나 AOP같은 기능뿐만 아니라, Servlet 기반의 Web 개발을 위한 MVC Framework를 제공한다
* Spring은 MVC 패턴과 Front Controller Pattern을 제공
* Transaction 처리, DI, AOP 등을 쉽게 사용할 수 있다

## 구성요소 (6가지)
> DispatcherServlet, HandlerMapping, ViewResolver는 Spring이 내부적으로 해준다. **즉, DispatcherServlet, Handler Mapping, VIewResolver는 setting만 해주고 Controller 와 결과 화면만 만들면 된다! **

### 1. DispatcherServlet (Front Controller)
* **Front controller 역할 수행 **
(i) 모든 클라이언트의 요청을 받음 
(ii) Controller에게 요청 전달 
(iii) Controller 가 리턴한 결과를 view에 전달
* Spring이 해줌
### 2. Handler Mapping
* 클라이언트의 요청 url을 어떤 컨트롤러가 처리할지 결정 -> literally "Mapping"
* DispatcherServlet은 하나 이상의 핸들러 매핑을 가질 수 있음 (like Mvc patterns in Servlet)
* Spring이 해줌
### 3. Controller
* 클라이언트의 요청을 처리한 뒤 Model 호출
* 결과를 DispatcherServlet에게 전달
### 4. ModelAndView
* Controller가 처리한 데이터 및 화면에 대한 정보를 보유한 객체
### 5. ViewResolver
* Controller가 리턴한 뷰 이름을 기반으로, 컨트롤러의 결과페이지를 보여줄 view를 결정
* Spring이 해줌
### 6. View
* 응답화면 생성

# Spring MVC 구현
>## Application 구현 과정
1. web.xml에 DispatcherServlet 등록 및 Spring 설정파일 등록
2. 설정파일에 HandlerMapping 설정
3. Controller 구현 및 Context 설정 파일(servlet-context.xml)에 등록
4. Controller와 JSP의 연결을 위해 View Resolver 설정
5. JSP 코드 작성

**[Tip] 좋은 디자인은 Controller가 많은 일을 하지 않고, Service에 처리를 위임하는 코드이다!**
## Step 1 : web.xml - DispatcherServlet 설정
```xml
<!-- Processes application requests -->
<servlet>
	<servlet-name>appServlet</servlet-name>
	<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
	<init-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>/WEB-INF/spring/appServlet/servlet-context.xml</param-value>
	</init-param>
	<load-on-startup>1</load-on-startup>
</servlet>
		
<servlet-mapping>
	<servlet-name>appServlet</servlet-name>
	<url-pattern>/</url-pattern>
</servlet-mapping>
```
### 요소 설명
1. `<init-param>`: `<init-param>`을 설정하지 않으면 `<servlet-name>-servlet.xml`파일에서 applicationContext 정보를 로드한다
2. `Spring Container` : 설정 파일의 내용을 읽고 ApplicationContext 객체를 생성한다
3. `<url-pattern>`: DispatcherServlet이 처리하는 **URL Mapping Pattern**을 정의
4. `<load-on-startup>1</load-on-startup>`: 설정 시 WAS startup시 초기화 작업을 진행
** DispatcherServlet은 Servlet이기 때문에, 1개 이상의 DispatcherServlet을 설정할 수 있다! 
-> how ? servlet 테그를 여러개 생성하면 된다)

## Step 2 : HandlerMapping
위의 디스패처서블릿에서, servlet-context.xml 파일을 읽어들이는데 이때 이 servlet-context.xml 안에서 맵핑을 할 수 있다.
```xml
<!-- Handles HTTP GET requests for /resources/** by efficiently serving up static resources in the ${webappRoot}/resources directory -->
	<resources mapping="/resources/**" location="/resources/" />

	<!-- Resolves views selected for rendering by @Controllers to .jsp resources in the /WEB-INF/views directory -->
	<beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<beans:property name="prefix" value="/WEB-INF/views/" />
		<beans:property name="suffix" value=".jsp" />
	</beans:bean>
	
	<context:component-scan base-package="com.study.mvc" />
```
`<resources mapping>` : resrouce관련 처리
`view resolver view resolver`: jsp의 경로를 주는 요소이다.
위 코드에서 , prefix에는 /WEB-INF/views/ suffix에는 .jsp 를 붙이고 있다.
예를 들어 referencing할 주소가 login 이라고 한다면 login 앞에 prefix를 붙이고 뒤에 suffix가 되어서 /WEB-INF/views/login.jsp 라는 주소를 생성해낸다.
따라서, login만 설정해주면 주소를 알아서 생성해준다

## Step 3 : Controller Class 작성
### POJO : 옛날 자바 객체의 형태를 유지함
>
### Previously,
Context 설정 파일에 Controller 등록 
```xml
<beans:bean class="com.study.mvc.HomeController"/>
```
* bean : 객체
### Now,
@Controller 라는 annotation을 주게 되면 component-scan을 사용할 때 스캔된다.

```java
@Controller
public class HomeController{
	
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
    	@RequestMapping(value="/", method = RequestMethod.GET)
  	public String home(Locale locale, Model model){
 	   logger.info("Wellcome home! The Client locale is : {} ",locale);
   	   model.addAttribute("message", "안뇽 스프링~");
       return index;
    }
    @AutoWired
    private Service service;
   @RequestMapping("/login") //login과 맵핑
   public ModelAndView login(@RequestParam Map<String, String> map){
   //code goes in here...
   }
}
```
* `@RequestMapping("")` : 요청 URL mapping 정보를 설정. 클래스 타입과 메소드에 설정 가능
* `HTTP method` : 같은 URL 요청에 대해 HTTP Method(GET, POST)에 따라 `method = RequestMethod.GET` 과 `method = RequestMethod.POST`를 명시하여, 서로 다른 메소드를 mapping할 수 있다.

>Example 
```java
@RequestMapping(value = "/index.do", method = RequestMethod.GET)
public String home1(Model model){
	model.addAttribute("message", "Get method was called " );
    return "index";
}
@RequestMapping(value = "/index.do", method = RequestMethod.POST)
public String home2(Model model){
	model.addAttribute("message", "Post method was called ");
    return "index";
}
```

* `@RequestParam` : "http://localhost/study/index.do?name=June&age=24"라는 url 호출이 있다고 가정했을 때, `@RequestParam`을 통하여 쉽게 파라미터를 맵핑할 수 있다. 아래는 parameter 안에 `RequestParam`을 주어 사용한 예시이다.

>Example
```java
@RequestMapping(value = "/index.do", method = RequestMethod.GET)
public String home1(@RequestParam("name") String name, @RequestParam("age") int age, Model model){
	model.addAttribute("message", name+"님은 "+age+살인가요? );
    return "index";
}
```


* 객체 전송 : Servlet의 ObjectDto.setName(), ObjectDto.setAge() 등등을 세팅하였다면, Spring Web Mvc에서는 form에 입력한 data를 자바 Bean 객체를 이용하여 전송할 수 있다.(배열도 가능하다)

>Example
```html
<h1>HTML 코드</h1>
<form method = "POST" action = "${root}/FAQ/post.do">
  제목: <input type = "text" name = "subject"><br>
  문의사항 : <textarea name = "question"></textarea><br>
  <input type = "submit" value = "질문하기">
```
```java
// DTO 클래스
public class FAQDto{
	private void setSubject(String subject){ this.subject = subject; }
   	private void setQuestion (String question){ this.question = question; }
}
```
위 DTO 클래스에서 HTML/JSP의 form에서 세팅한 네임을 자동으로 매칭해주어 코드가 간단해진다.
```java
//Controller 클래스
@Controller
@RequestMapping("/FAQ")
public class FAQController{
	@RequestMapping(value = "/post.do", method = RequestMethod.GET)
    public String write(){
    return "FAQ/post";
    }
    @RequestMapping(value = "/post.do", method = RequestMethod.POST){
    return "FAQ/Posted";
    }
}
```





## Step 4 : View Resolver 설정
* Controller와 response page을 연결하기 위해 view resolver을 설정해준다.
* view resolver는 response page의 경로를 전달해준다
```xml
<beans: bean class = "com.study.mvc.HomeController"/>
<beans: bean class = "org.springframework.web.servlet.view.InternalResourceViewResolver">
  	<beans:property name = "prefix" value = "/WEB-INF/views/" />
  	<beans:property name = "suffix" value = ".jsp"/>
</beans: bean>
```
`servlet-context.xml`파일에서 view resolver을 설정해준다.
[Tip] Servlet에서는 "index.jsp"를 주었지만, 위에 suffix에서 .jsp를 이미 주고있기 때문에 .jsp를 주면 404 에러가 뜬다 !! 주의 !
## Step 5 : JSP 코드 작성
```jsp
//...생략 (index.jsp 파일)
<h3>hello</h3>
$ {message}
```
JSP 파일은 Servlet때와 마찬가지로 작성한다. 
다만, 이제는 Controller에서 영역.setAttribute("message", "안녕~ 배고프다 ㅠㅠ"); 로 작성하는게 아닌 `addAttribute`를 사용한다.
