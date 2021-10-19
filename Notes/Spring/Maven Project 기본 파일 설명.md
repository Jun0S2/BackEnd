# Maven Project
![image](https://user-images.githubusercontent.com/36508552/137951619-27d1f916-65fd-48b3-b6f7-984ce9b2f9c8.png)
Maven Project를 생성하고 나면, Servlet-context.xml이라던가 web.xml이라던가 root-context.xml이라던가가 기본으로 생성되는걸 볼 수 있다.

# web.xml
web.xml의 기본 코드는 아래와 같다.

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app version="2.5" xmlns="http://java.sun.com/xml/ns/javaee"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee https://java.sun.com/xml/ns/javaee/web-app_2_5.xsd">

	<!-- The definition of the Root Spring Container shared by all Servlets and Filters -->
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>/WEB-INF/spring/root-context.xml</param-value>
	</context-param>
	
	<!-- Creates the Spring Container shared by all Servlets and Filters -->
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>

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

</web-app>

```
1. DispatcherServlet을 설정

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
`<servlet mapping>` 을 보면 url-pattern이 '/' 로 되어있는데, 즉, 이 '/'를 만나면 appServlet이라는 서블릿을 찾고, 그 위의 `<servlet>`을 보면, appServlet을 찾을 수 있다. 이 appServlet은 ispatcherServlet을 생성하고 있다 (`init-parama`이 생성해주고, 이 디스페치서블릿이 할 일들은 servlet-context.xml안에 저장되어 있다. )

#### 요소 설명
1. `<init-param>`: `<init-param>`을 설정하지 않으면 `<servlet-name>-servlet.xml`파일에서 applicationContext 정보를 로드한다
2. `Spring Container` : 설정 파일의 내용을 읽고 ApplicationContext 객체를 생성한다
3. `<url-pattern>`: DispatcherServlet이 처리하는 **URL Mapping Pattern**을 정의
4. `<load-on-startup>1</load-on-startup>`: 설정 시 WAS startup시 초기화 작업을 진행
** DispatcherServlet은 Servlet이기 때문에, 1개 이상의 DispatcherServlet을 설정할 수 있다!

2. Event 발생
```xml
	<!-- The definition of the Root Spring Container shared by all Servlets and Filters -->
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>/WEB-INF/spring/root-context.xml</param-value>
	</context-param>
	
	<!-- Creates the Spring Container shared by all Servlets and Filters -->
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>
```
#### 요소 설명
1. `<listener>` : `<listener>`은 big brothers 같은 녀석이다. 항상 감시하다가 이벤트가 발생하면 `<context-param>`의 root-context.xml을 읽어 들인다.

# servlet-context.xml 과 root-context.xml
위에서 본 기본 web.xml에서 디스패처에서 servlet-context.xml을 읽어 들이고, 리스너가 root-context.xml을 읽어들이는 코드를 확인해 보았다.<br>
그렇다면, 이 두 xml파일은 무엇일까 ? <br>
시작하기 앞서, servlet-context.xml 은 "웹과 관련된 context"를 설정하는 xml이고 root-context.xml은 "웹과 관련되지 않은 context"를 설정하는 (ex: dao) xml이다.

## servlet-context.xml

## root-context.xml



