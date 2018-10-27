package moviedam.member;

public class FollowDataBean {
	private String mem_id;
	private String target_mem_id;
	private String fol_type;
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getTarget_mem_id() {
		return target_mem_id;
	}
	public void setTarget_mem_id(String target_mem_id) {
		this.target_mem_id = target_mem_id;
	}
	public String getFol_type() {
		return fol_type;
	}
	public void setFol_type(String fol_type) {
		this.fol_type = fol_type;
	}
}
