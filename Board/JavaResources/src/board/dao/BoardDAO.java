package board.dao;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.board.dto.BoardDto;
import com.ssafy.util.SqlSession;

public class BoardDAO {
	//전체 게시글 리스트 조회
	public List<BoardDto> selectAllBoard() throws SQLException{
		return SqlSession.selectList(BoardDto.class, "select * from board order by no desc");//최신글부터
	}
	//상세 게시물 조회: 글번호로 게시글 조회
	public BoardDto selectBoard(int no) throws SQLException{
		return SqlSession.selectOne(BoardDto.class, "select * from board where no = ?",no);
	}
	//게시물 추가
	public int insertBoard(BoardDto board)throws SQLException{
		return SqlSession.insert("insert into board(title, writer, content) values(?,?,?)", board.getTitle(),board.getWriter(),board.getContent());
	}
	//게시물 수정: 내용, 제목만 가능. 작성자는 못바꾸징
	public int updateBoard(BoardDto board) throws SQLException{
		return SqlSession.update("update board set title = ? , content = ? where no = ?", board.getTitle(),board.getContent(),board.getNo());
	}
	//게시물 삭제
	public int deleteBoard(int no) throws SQLException{
		return SqlSession.delete("delete from board where no = ?", no);
	}
	
}
