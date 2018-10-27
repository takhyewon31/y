package moviedam.board;
import java.sql.Timestamp;

public class ArticleDataBean {
	private int article_id; 
    private String article_writer;
    private String article_title;
    private String article_content;
    private Timestamp reg_date;
    private int article_hits; //조회수
    private int article_gets; //추천수
    private String article_file;
    private String category;
   
	
    public int getArticle_id() {
		return article_id;
	}
	public void setArticle_id(int article_id) {
		this.article_id = article_id;
	}
	public String getArticle_writer() {
		return article_writer;
	}
	public void setArticle_writer(String article_writer) {
		this.article_writer = article_writer;
	}
	public String getArticle_title() {
		return article_title;
	}
	public void setArticle_title(String article_title) {
		this.article_title = article_title;
	}
	public String getArticle_content() {
		return article_content;
	}
	public void setArticle_content(String article_content) {
		this.article_content = article_content;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public int getArticle_hits() {
		return article_hits;
	}
	public void setArticle_hits(int article_hits) {
		this.article_hits = article_hits;
	}
	public int getArticle_gets() {
		return article_gets;
	}
	public void setArticle_gets(int article_gets) {
		this.article_gets = article_gets;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getArticle_file() {
		return article_file;
	}
	public void setArticle_file(String article_file) {
		this.article_file = article_file;
	}

	
}