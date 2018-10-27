package moviedam.board;

import java.sql.Timestamp;

public class CommentRestDataBean {
	private int cmt_id;
	private String cmt_writer;//댓글 작성자
	private String cmt_content;//댓글 내용
	private Timestamp cmt_date;//댓글 작성일
	private int cmt_ref;//부모 게시글
	private int cmt_parent;//부모 댓글
	private int cmt_restep; //댓글 순서
	private int cmt_relevel; //글의 레벨
	
	
	public int getCmt_id() {
		return cmt_id;
	}
	public void setCmt_id(int cmt_id) {
		this.cmt_id = cmt_id;
	}
	public String getCmt_writer() {
		return cmt_writer;
	}
	public void setCmt_writer(String cmt_writer) {
		this.cmt_writer = cmt_writer;
	}
	public String getCmt_content() {
		return cmt_content;
	}
	public void setCmt_content(String cmt_content) {
		this.cmt_content = cmt_content;
	}
	public Timestamp getCmt_date() {
		return cmt_date;
	}
	public void setCmt_date(Timestamp cmt_date) {
		this.cmt_date = cmt_date;
	}
	public int getCmt_ref() {
		return cmt_ref;
	}
	public void setCmt_ref(int cmt_ref) {
		this.cmt_ref = cmt_ref;
	}
	public int getCmt_parent() {
		return cmt_parent;
	}
	public void setCmt_parent(int cmt_parent) {
		this.cmt_parent = cmt_parent;
	}
	public int getCmt_restep() {
		return cmt_restep;
	}
	public void setCmt_restep(int cmt_restep) {
		this.cmt_restep = cmt_restep;
	}
	public int getCmt_relevel() {
		return cmt_relevel;
	}
	public void setCmt_relevel(int cmt_relevel) {
		this.cmt_relevel = cmt_relevel;
	}
	
}
