package dao;

import java.sql.SQLException;

import com.ssafy.util.SqlSession;

public class ApplicationDAO {
	public int insertApplicant(ApplicationDto applicant) throws SQLException {
		return SqlSession.insert("insert into Application(name,phone,email,degree,courses,choose,agreement) values(?,?,?,?,?,?,?)", 
		applicant.getName(),applicant.getPhone(),applicant.getEmail(),applicant.getDegree(),applicant.getCourses(),applicant.getChoose(),applicant.getAgreement()
		);	
	}
}
