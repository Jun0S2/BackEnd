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
