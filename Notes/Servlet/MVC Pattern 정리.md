# MVC Pattern
MVC Pattern ( Model-View-Controller)
* Model : 데이터 처리
* View : jsp
* Controller : 요청 과 응답 referencing
* 구성
  1. Service: 일처리
  2. Dao : Database 로직 처리
  3. Dto : 바구니
  4. JSP : 화면단
 
 
# Models

## Model 1 구조 
model 1은 view 와 logic을 JSP 페이지 하나에서 처리하는 구조
  1. 장점 : 개발 시간 단축, 비용 감소
  2. 단점 
    * 유지보수에 불리 : 만약 SQLException이 발생했을 경우 혹은 계산이 잘못된 경우 여러가지 데이터와 로직 중 잘못된 로직을 찾기 힘듦
    * 확장성 x (신기술, framework등 )
    * Backend와 Frontend의 혼재로 인해 분업이 힘듦
    * java코드와 섞이기 때문에 jsp 코드가 복잡해짐
## MVC 구조
분업화가 일어나기 때문에 유지보수와 확장하기 편리하다
