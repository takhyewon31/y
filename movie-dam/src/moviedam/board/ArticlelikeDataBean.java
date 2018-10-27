package moviedam.board;

public class ArticlelikeDataBean {
	private int article_like_id;
	private int board_id;
	private int article_id;
	private String mem_id;
	private String like_type;
	
	public int getArticle_like_id() {
		return article_like_id;
	}
	public void setArticle_like_id(int article_like_id) {
		this.article_like_id = article_like_id;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public int getArticle_id() {
		return article_id;
	}
	public void setArticle_id(int article_id) {
		this.article_id = article_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getLike_type() {
		return like_type;
	}
	public void setLike_type(String like_type) {
		this.like_type = like_type;
	}
	
}
