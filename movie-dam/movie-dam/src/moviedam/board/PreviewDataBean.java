package moviedam.board;
import java.sql.Timestamp;

public class PreviewDataBean {
	private int article_id;
	private String article_title;
	private String preview_date;
	private String preview_region;
	private Timestamp reg_date;
	private String original_url;
	private String article_file;
	private String cinema;
	public int getArticle_id() {
		return article_id;
	}
	public void setArticle_id(int article_id) {
		this.article_id = article_id;
	}
	public String getArticle_title() {
		return article_title;
	}
	public void setArticle_title(String article_title) {
		this.article_title = article_title;
	}
	public String getPreview_date() {
		return preview_date;
	}
	public void setPreview_date(String preview_date) {
		this.preview_date = preview_date;
	}
	public String getPreview_region() {
		return preview_region;
	}
	public void setPreview_region(String preview_region) {
		this.preview_region = preview_region;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getOriginal_url() {
		return original_url;
	}
	public void setOriginal_url(String original_url) {
		this.original_url = original_url;
	}
	public String getArticle_file() {
		return article_file;
	}
	public void setArticle_file(String article_file) {
		this.article_file = article_file;
	}
	public String getCinema() {
		return cinema;
	}
	public void setCinema(String cinema) {
		this.cinema = cinema;
	}
	
}
