# 요청 처리 방식
Spring MVC 로 redirect 요청을 처리하는 방식을 크게 4가지 방법으로 나누어 볼 수 있다.
** forward 방식으로 하고싶다면, viewResolver에서 prefix와 suffix를 추가해주기때문에 해당 jsp이름만 String 형태로 리턴해주면 된다. 이번 포스팅에서는 forward 방식이아닌, redirect 방식을 Spring 에서 처리하는 방식을 알아보려고 한다.
## Redirect 방식
format : `"redirect:/파일명.jsp"`
forward 방식이 아닌 sendRedirect 방식이다 (HttpServlet 에서는 sendRedirect를 하기 위해서 `response.sendRedirect(request.getContextPath() + "주소.jsp"` 형식으로 썻었다.)

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 1 - Main JSP File 생성</h3>
</div>

redirect 방식을 구현하기 위해 메인페이지를 생성한다.
>메인 jsp 파일을 생성하여, redirect를 확인해볼 수 있는 링크를 생성한다
```jsp
<h2><a href = "${root}/request/test01">요청</a></h2>
```
root/request/test01을 호출하는 링크이다. 따라서, 이를 호출할 수 있도록 request/test01을 컨트롤러에 생성한다.

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 2 - Controller 생성</h3>
</div>

#### 🎮 Controller 생성시 주의사항 🎮

<hr>

**컨트롤러를 처음 생성했을 때, 반드시 @Controller("package명")처리**를 해주는 것을 잊으면 안된다. Controller는 404 에러의 주범이 되기 때문이다. 또한, "package명"을 컨트롤러에 주지 않는다면 문제가 생길 수 있다.

```
예를 들어, 
package t1과 package t2가 있다.
package t1과 package t2에는 각각 Test라는 클래스가 있다. 이는 오류가 생기지 않는다. 
```

같은 패키지 안에서 Test 라는 클래스를 두개 생성할 수 있지만, **서로다른 패키지 안에서는 다른 패키지에 사용된 클래스이름일지라도 사용 가능하기 때문이다.**

**Spring에서는 따로 이름을 정해두지 않는다면** `@GetMapping`**이나** *`@RequestMapping` **처리시 bean을 등록할 때, 클래스의 앞글자를 소문자를 바꾸어 아이디로 등록한다. **

```
따라서, t1패키지의 id는 test가 된다. 하지만, t2의 패키지의 id역시 test가 된다
```

<img src ="https://images.velog.io/images/junbee/post/b7463739-76ec-41a0-8de2-0c33b24cedd6/image.png" style = "align : center ; border : 3px solid black;" >

Spring은 bean을 등록 할때, `<bean id = "something" class= "className">`형식으로 하게되는데 id가 중복되면 안된다. 따라서, 다른 패키지에 있더라도 id 이름이 둘다 test가 되어버리기 때문에 오류가 발생하게 되는것이다. 

<hr>

주의사항을 숙지한 후, Controller을 설정해 준 후, step 1에서 호출한 경로인 context/request/test01을 생성하기 위해서 클래스명에 request를 맵핑하고 새로운 메서드를 만들어 test01을 맵핑해 준다. 매서드에 request/test01을 맵핑해도 상관 없지만, 남은 방법에서도 request/test숫자 로 맵핑할것이기 때문에 같은 클래스를 재사용할 수 있도록 클래스에 request를 맵핑하겠다.

#### Controller 지정 및 맵핑
```java
@Controller("com.mvc.basic._01request")//숫자로 시작할 수 없기 때문에 패키지명에 _를 더해주었다
@RequestMapping("/request")
public class Test{
	//방법 1~ 7까지 코드
}
```

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 3 - Redirect를 이용한 요청 방식을 처리하는 메서드 생성</h3>
</div>

```java
@RequestMapping("/test01")// 가독성을 위해 '/'를 빼주는것을 추천
public String test01(){
	System.out.println("reloaded index1");
	return "redirect:/index1.jsp";
}
```
`redirect:`를 사용하면, redirect 방식으로 부르게 된다.

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 4 - 결과 확인</h3>
</div>

<br>
결과를 확인해보면, index1.jsp가 다시 로딩되는것을 볼 수 있다. 콘솔창에 메시지가 잘 찍히는 지 확인해보면 된다. 
즉, 다른 페이지로 이동하고 싶다면, webapp에 이동할 페이지를 하나 더 생성하여 확인해볼 수 있다.

<p align="center"><img src = "https://images.velog.io/images/junbee/post/010aa91f-4c98-4608-8167-cb66b70c2c37/image.png" ></p> <br>

result1.jsp를 생성하고 Step3의 redirect경로를 /result1.jsp로 바꾸어 보면,<br>

<p align="center">
  <img src="https://images.velog.io/images/junbee/post/c9b1ec17-1ed2-4482-a364-33f04bfac343/redirect1.gif" alt="animated" />
</p><br>

정상적으로 잘 작동되는것을 확인해 볼 수 있다.

## Multiple Path
format : `@RequestMapping({"path1", "path2"})`
path1과 path2로 요청이 들어왔을 경우 같이 처리하고 싶을 때 사용하는 방식이다.

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 1 - JSP 생성</h3>
</div>

>메인 JSP에서, 요청3 링크와 요청 4 링크를 눌렀을 때, 같은 페이지로 로딩
```jsp
	<h2><a href = "${root}/request/test03">요청3</a></h2>
	<h2><a href = "${root}/request/test04">요청4</a></h2>    
```

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 2 - Controller에 해당 메서드 추가</h3>
</div>

```java
@RequestMapping({"test03","test04"})
public String test034(){
	System.out.println("test 03 과 test04 를 같은 페이지로 호출");
	return "redirect:/result1.jsp";
}
```    
RequestMapping에 배열 형태로 담는다.

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 3 - 결과 확인</h3>
</div>

<hr>
## Multiple Path
format : `@RequestMapping({"path1", "path2"})`
path1과 path2로 요청이 들어왔을 경우 같이 처리하고 싶을 때 사용하는 방식이다. <br>

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 1 - JSP 생성</h3>
</div>

>메인 JSP에서, 요청3 링크와 요청 4 링크를 눌렀을 때, 같은 페이지로 로딩

```jsp
	<h2><a href = "${root}/request/test03">요청3</a></h2>
	<h2><a href = "${root}/request/test04">요청4</a></h2>    
```

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 2 - Controller에 해당 메서드 추가</h3>
</div>

```java
@RequestMapping({"test03","test04"})
public String test034(){
	System.out.println("test 03 과 test04 를 같은 페이지로 호출");
	return "redirect:/result1.jsp";
}
```    
RequestMapping에 배열 형태로 담는다.<br>

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 3 - 결과 확인</h3>
</div>
<br>
<p align="center">
  <img src="https://images.velog.io/images/junbee/post/0f2693e6-09ca-4c67-9c54-0363ad35ab1d/redirec2.gif" alt="animated" />
</p><br>

요청링크 3과 4를 눌렀을때, 둘다 같은 페이지로 이동하는것을 확인해볼 수 있다.


## @RequestMapping을 이용한 Get 과 Post 방식

format : `@RequestMapping(path)`
Get 과 Post 방식을 `@RequestMapping`을 사용하여 redirect하는방식이다.
`value`값을 컨트롤러의 해당 메서드에 준다.

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 1 - JSP 생성</h3>
</div>

>
```jsp
<h2><a href = "${root}/request/test05">요청5 : GET 방식</a></h2>
	<div>
		<form method = "post" action = "${root}/request/test05">
			<button>요청5: POST방식</button>
		</form>
	</div>
```
action="${root}/Controller에서 찾아야하는 애들 을 주는 것을 잊지 말자. ~~컨트롤러에서 찾는다는걸 자꾸 깜빡한다....나만그런가~~

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 2 - Controller에 해당 메서드 추가</h3>
</div>

#### GET 방식

`value`에 해당 **경로(jsp가 컨트롤러내에서 찾을 위치)** 를, method에 Get 방식일 경우 `RequestMethod.GET`을 Post방식일 경우 `RequestMethod.POST`를 설정해준다.
```java
/**Get 방식 요청*/
	@RequestMapping(value = "test05" , method = RequestMethod.GET)
	public String test05Get(){
		System.out.println("test 05 호출-GET");
		return "redirect:/index1.jsp";
	}
 ```
 #### POST 방식
 ```java
/**Post 방식 요청*/
	@RequestMapping(value = "test05" , method = RequestMethod.POST)
	public String test05Post(){
		System.out.println("test 05 호출-POST");
		return "redirect:/index1.jsp";
	}
```
 > ### 왜 value 값을 주어야 할까 ? 
 원래는 @RequestMapping(Value = " " ) 이지만 
 ```
 1. 속성이 value인 경우
 2. 속성이 하나인 경우
```
** 위 두 조건을 둘 다 만족하면 value를 생략할 수 있다. **
하지만, 위의 GET과 POST의 맵핑 정보를 보면 알 수 있듯이 RequestMapping은 속성을 두가지 맵핑하고 있다. value인 test05과 method인 RequestMethod.GET/POST.
따라서, 2번조건을 충족하지 못하기 때문에, ** value를 생략할 수 없다.**

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 3 - 결과 확인</h3>
</div>

<p style="float:left;">
  <img src="https://images.velog.io/images/junbee/post/27dd0db6-aad3-4f7b-bd82-77631349e5de/test05.gif" alt="animated" /></p>
  
 <p style = "float:left">
  <img src = "https://images.velog.io/images/junbee/post/27fb59e4-f294-40db-aeb1-71432a5ec260/test05.PNG">
</p>

<div style="clear:both"></div>
Get 과 POST 방식을 눌렀을 때, 콘솔에 각각의 메시지들이 찍힌 것을 볼 수 있다. (test034는 위의 메서드에서 호출된 결과이다)

## @GetMapping과 @PostMapping을 이용한 Get 과 Post 방식

format : `@GetMapping()` 과 `@PostMapping()`
GetMapping과 PostMapping annotation을 사용한 방식이다.

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 1 - JSP 생성</h3>
</div>

>```jsp
<h2><a href = "${root}/request/test06">요청6 : GET 방식</a></h2>
<form method = "post" action = "${root}/request/test06">
	<button>요청6 : POST 방식</button>
</form>
```

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 2 - Controller에 해당 메서드 추가</h3>
</div>

```java
/**Get 방식 요청*/
@GetMapping("test06")
public String test06Get(){
	System.out.println("test 06");
	return "redirect:/index1.jsp";
}
/**Post*/
@PostMapping("test06")
public String test06Post(){
	System.out.println("test 06");
	return "redirect:/index1.jsp";
}

```
annotation을사용하면, value값을 더할 필요가 없어서 가독성이 더 좋다.<br>

<div style = "background-color:#DAF7A6;">
  <h3 style = "margin:3% 2%;" > Step 3 - 결과 확인</h3>
</div>

<p style="float:left;">
  <img src="https://images.velog.io/images/junbee/post/31760a44-e9a0-48c4-aabd-4cabfb280dd2/test06.gif" alt="animated" /></p>
 <p style = "float:right">
  <img src = "https://images.velog.io/images/junbee/post/154325e8-6ff3-4225-b791-6107fa2057d2/test06.PNG">
</p>
<div style="clear:both"></div>
Get 과 POST 방식을 눌렀을 때, 콘솔에 각각의 메시지들이 찍힌 것을 볼 수 있다.
