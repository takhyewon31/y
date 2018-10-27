package moviedam.debate;
import java.sql.Timestamp;

public class ChanbanCommentDataBean {
	private int cb_cmt_id;
	private String cb_cmt_writer;//댓글 작성자
	private String cb_cmt_content;//댓글 내용
	private Timestamp cb_cmt_date;//댓글 작성일
	private int cb_cmt_ref;//부모 게시글
	private int cb_cmt_group;//댓글그룹(대댓글사용)
	private int cb_cmt_step; //댓글 순서
	private int cb_cmt_level; //글의 레벨
	private String cb_cmt_type;
	
	public int getCb_cmt_id() {
		return cb_cmt_id;
	}
	public void setCb_cmt_id(int cb_cmt_id) {
		this.cb_cmt_id = cb_cmt_id;
	}
	public String getCb_cmt_writer() {
		return cb_cmt_writer;
	}
	public void setCb_cmt_writer(String cb_cmt_writer) {
		this.cb_cmt_writer = cb_cmt_writer;
	}
	public String getCb_cmt_content() {
		return cb_cmt_content;
	}
	public void setCb_cmt_content(String cb_cmt_content) {
		this.cb_cmt_content = cb_cmt_content;
	}
	public Timestamp getCb_cmt_date() {
		return cb_cmt_date;
	}
	public void setCb_cmt_date(Timestamp cb_cmt_date) {
		this.cb_cmt_date = cb_cmt_date;
	}
	public int getCb_cmt_ref() {
		return cb_cmt_ref;
	}
	public void setCb_cmt_ref(int cb_cmt_ref) {
		this.cb_cmt_ref = cb_cmt_ref;
	}
	public int getCb_cmt_group() {
		return cb_cmt_group;
	}
	public void setCb_cmt_group(int cb_cmt_group) {
		this.cb_cmt_group = cb_cmt_group;
	}
	public int getCb_cmt_step() {
		return cb_cmt_step;
	}
	public void setCb_cmt_step(int cb_cmt_step) {
		this.cb_cmt_step = cb_cmt_step;
	}
	public int getCb_cmt_level() {
		return cb_cmt_level;
	}
	public void setCb_cmt_level(int cb_cmt_level) {
		this.cb_cmt_level = cb_cmt_level;
	}
	public String getCb_cmt_type() {
		return cb_cmt_type;
	}
	public void setCb_cmt_type(String cb_cmt_type) {
		this.cb_cmt_type = cb_cmt_type;
	}
	
	
	
	

}
