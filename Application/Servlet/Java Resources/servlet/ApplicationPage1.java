package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ssafy.application.ApplicationDAO;
import com.ssafy.application.ApplicationDto;

/** Method 1 : Servlet
 *  문서의 내용대로 입력(html) + 출력(서블릿)으로 작성
 *  
 * */

@WebServlet("/servlet/application")
public class Test01 extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/html;charset = utf-8");
		request.setCharacterEncoding("utf-8");
		//사용자 데이터 꺼내기(parameter)
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String degree = request.getParameter("degree");
		
		//multiple String받기
		String courses[] = request.getParameterValues("courses");
		String c="";
		if(courses==null) {c="입력하지 않음";
		}else {for(String s : courses) {c+= s+" ";}}
		
		String choose = request.getParameter("choose");
		if(choose=="선택하세요")choose="";
		String agreement = request.getParameter("agreement");
		
		//데이터베이스에 저장

		ApplicationDto app = new ApplicationDto();

		app.setName(name==null?"":name);
		app.setPhone(phone==null?"":phone);
		app.setEmail(email==null?"":email);
		app.setDegree(degree==null?"선택안함":degree);//db에 저장
		app.setCourses(c);
		app.setChoose(choose=="unselected"?" ":choose);
		app.setAgreement(agreement==null?" ":"동의");

	
		
		ApplicationDAO dao = new ApplicationDAO();
		try {
			dao.insertApplicant(app);
			}
		catch(SQLException e) {throw new ServletException(e);}
	
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
}
