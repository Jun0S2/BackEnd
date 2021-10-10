package board.dto;

import java.util.Date;
public class BoardDto {

    private int no;
    private String title;
    private Date regDate;
    private String writer;
    private int viewCnt;
    private String content;

    public void setNo(int no) { 
        this.no = no;
    }

    public int getNo() { 
        return no;
    }

    public void setTitle(String title) { 
        this.title = title;
    }

    public String getTitle() { 
        return title;
    }

    public void setRegDate(Date regDate) { 
        this.regDate = regDate;
    }

    public Date getRegDate() { 
        return regDate;
    }

    public void setWriter(String writer) { 
        this.writer = writer;
    }

    public String getWriter() { 
        return writer;
    }

    public void setViewCnt(int viewCnt) { 
        this.viewCnt = viewCnt;
    }

    public int getViewCnt() { 
        return viewCnt;
    }

    public void setContent(String content) { 
        this.content = content;
    }

    public String getContent() { 
        return content;
    }
}
