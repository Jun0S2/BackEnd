# Maven Project 생성 방법
### Project > Spring Legacy Project 선택
![1](https://user-images.githubusercontent.com/36508552/137943437-370ce4fe-7477-4970-9aa4-b746a462540c.png)
### Spring MVC Project 선택
<p align = "center"><img src ="https://user-images.githubusercontent.com/36508552/137943541-bd534524-b628-4cbb-b80a-e766ef2a4f50.png"></p>

### Top Level Package
Top Level Package를 생성할때는 3index 를 지키는 것이 좋다.
ex: com.project.rootName
<p align = "center"><img src ="https://user-images.githubusercontent.com/36508552/137943599-d6bbe2fe-eb39-4ba5-83d7-99672b4a34b4.PNG"></p><br>

** 참고로 이 세번째 인덱스의 rootName이 프로젝트를 만들었을 때 루트 경로가 된다. **<br>
ex: 만일 프로젝트명이 com.user.mvc 라면, 프로젝트를 생성했을 때, 루트명이 mvc로 잡히는걸 볼 수 있다.

<p align = "center" ><img src = "https://user-images.githubusercontent.com/36508552/137947396-e796ef69-a3eb-45ca-a504-fe83669bbb71.png"></p>


# Maven Project Explorer 설명
<p align = "center"><img src ="https://user-images.githubusercontent.com/36508552/137943884-9abbaf31-e36a-40bf-b3a1-67b5839042d5.PNG"></p>

## src/main/java
자바 코딩 영역
## src/main/resources
설정이 들어가는 영역 (ex : MyBatis)
## src/test/java
UnitTest 등을 처리하는 영역
## src 폴더
<p align="center"><img src = "https://user-images.githubusercontent.com/36508552/137944630-d0320147-626a-4091-9fbf-727593147ab7.png"></p>

### `src/main/webapp`
webapp은 web application의 약자로, web 과 관련된 컨텐츠는 이 폴더에 저장

### `src/main/webapp/WEB-INF`
### Previously in Servlet: 
JSP를 WEB-INF 폴더 안에 생성하면 읽지 못하니 주의해야함
** WEB-INF는 절대로 직접 접근할 수 없는 경로이다 ! **
### Now in Maven Project : 
src/main/WEB-INF/views 에 jsp 파일을 추가한다!

# 실행 방법
Servlet 에서는, index.html또는, index.jsp 를 실행 시켜서 프로젝트를 실행했다면,
Maven Project에서는 프로젝트 폴더를 잡고 실행시키면 된다.
