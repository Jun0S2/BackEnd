# [Spring MVC] 기본 기능(2) - 파라미터 처리

Spring MVC로 파라미터를 처리하는 방식에는 크게 6가지가 있다. Spring MVC는 `HttpServlteRequest`, `@RequestParam`, `매개변수` , `DTO` 를 사용하여 파라미터를 처리할 수 있다. 이 중, 가장 많이 쓰이는 방식은 `DTO` 방식이다.
# HttpServletRequest
Web MVC에서도 사용하였던 처리 방식으로, Spring MVC를 사용한다면 절대 사용하지 말자...
>Main Page:
```jsp
<h2>
    <a href = "${root}/param/test01?id=a&pw=b&name=홍길동">
    	@RequestParam 파라미터 처리
    </a>
</h2> 
```
test 01로 id = a, pw = b, name = 홍길동을 넘겨줌
> Controller:
```java
	@GetMapping("test01")
	public String test01(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		System.out.println("id: "+id);
		System.out.println("pw: "+pw);
		System.out.println("name: "+name);
		System.out.println("test01");
		return "redirect:/index2.jsp";
	}    
```

HttpServletRequest 객체를 이용하여, getParameters로 파라미터 값을 받는 방식이다. 
# @RequestParam

## 1. RequestParam("")
>Main Page : 
```jsp
<h2>
  <a href = "${root}/param/test02?id=a&pw=b">
    @RequestParam 파라미터 처리(name을 제거하면 에러:400잘못된 요청 )</a>
</h2> 
<h2>
  <a href = "${root}/param/test02?id=a&pw=b&name=홍길동">
    @RequestParam 파라미터 처리(name을 제거하면 에러:400잘못된 요청 )</a>
</h2> 
```
Controller : 
```java
@GetMapping("test02")
public String test02(@RequestParam("id") String userid,
			@RequestParam("pw" )String pw,
			@RequestParam("name") String name) {
	System.out.println("id: "+userid);
	System.out.println("pw: "+pw);
	System.out.println("name: "+name);
	System.out.println("test02");
	return "redirect:/index2.jsp";
}
```

* @ReuqestParam 사용
* 변수 이름은, 파라미터의 이름과 달라도 된다.
* 첫번째 링크에서, **name 파라미터 값이 없어 400 잘못된 요청 에러가 발생**한다.

## 2. RequestParam(Options)
>Main Page : 
```jsp
<h2>
  <a href = "${root}/param/test03?id=a&pw=b">
   @RequestParam 파라미터 처리 - 옵션 사용
   </a>
</h2> 
```
Controller : 
```java
@GetMapping("test03")
public String test03(@RequestParam("id") String userid,
		@RequestParam(value = "pw", defaultValue="0000" )String pw,
		@RequestParam(value = "name" ,required = false) String name) {
	System.out.println("id: "+userid);
	System.out.println("pw: "+pw);
	System.out.println("name: "+name);
	System.out.println("test03");
	return "redirect:/index2.jsp";
	}
```

### Option 사용 방법
1. value를 주고, defuaultValue를 설정하여 이 파라미터가 들어오지 않을 경우의 디폴트 파라미터 값을 설정한다.
```java
@RequestParam(value = "pw", defaultValue ="0000"); // pw가 들어오지 않을 경우, 자동으로 0000으로 설정
```
2. value를 주고, required = false를 해주면, 이 파라미터가 들어오지 않아도 자동으로 변수에 null 값이 설정된다.
```java
@RequestParam(value = "name" , required = "false"); //name이 들어오지 않을 경우, 자동으로 null값 설정
```
# 매개 변수 이름과 파라미터 이름 매칭
#### Spring은 매개 변수의 이름과 파라미터의 이름이 서로 같으면 기본적으로 파라미터 값을 매개변수의 파라미터에 값을 설정한다. 

#### 만일, 변수이름과 일치하는 파라미터 이름이 있으면 맵핑 되지만, 없는 경우는 변수가 오면 null값을 디폴트로 집어넣는다.
ex: Integer age -> null
따라서, int age 인 경우는 null값 설정이 안되기 때문에 오류가 난다.
#### 즉, 객체 타입으로 받아야 한다. ex: Integer, Character ...
>Main Page:
```jsp
<h2>
  <a href = "${root}/param/test04?id=a&pw=b&name=홍길동">
	매개변수 이름을 이용한 파라미터 처리
  </a>
</h2> 
```
Controller:
```java
	@GetMapping("test04")
	public String test04(String id, String pw, String name, Integer age) {
		System.out.println("id: "+id);
		System.out.println("pw: "+pw);
		System.out.println("name: "+name);
		System.out.println("age  :"+age);//null값 출력
		System.out.println("test04");
		return "redirect:/index2.jsp";
	}
```

* jsp를 보면, 파라미터이름을 id, pw, name으로 보내주고 있다. Controller에서 매개변수의 이름을 id, pw, name과 동일하게 맵핑해주었기 때문에 아무런 행동을 하지 않아도 스프링에서 자동으로 변수를 맵핑시켜준다. 

* age의 경우, 들어온 값이 없어 null로 출력된다. 
* 이때, age를 int로 바꾸면 에러가 발생한다.
# DTO 사용
DTO가 생성되어 있다면, 파라미터에 해당 DTO를 파싱해주면, DTO에 스프링에서 자동으로 파라미터를 맵핑해준다. 
가장 많이 쓰이고, 권장하는 방식이다
>Main Page :
```jsp
<h2>
    <a href = "${root}/param/test05?id=a&pw=b&name=홍길동">
	DTO를 이용한 파라미터 처리 - 가장 많이 쓰임
    </a>
 </h2>
```
Controller  :
```java
@GetMapping("test05")
public String test05(Member member) {
	System.out.println("id: "+member.id);
	System.out.println("pw: "+member.getPw());
	System.out.println("name: "+member.getName());
	System.out.println("test04");
	return "redirect:/index2.jsp";
}
```

* member.getPw() == member.pw
* 파라미터에 파싱한 DTO에 담긴다
