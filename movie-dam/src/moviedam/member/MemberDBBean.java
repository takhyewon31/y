package moviedam.member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDBBean {
	
	private static MemberDBBean instance = new MemberDBBean();
	
	public static MemberDBBean getInstance() {
		return instance;
	}
	
	private MemberDBBean() {}
	
	private Connection getConnection() throws Exception {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context) initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/miso");
	    return ds.getConnection();
	}
	
	public String insertMember(MemberDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String rs = "";
			        
		try{
			conn = getConnection();
			
			pstmt = conn.prepareStatement("insert into member values(?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, member.getMem_status());
			pstmt.setString(2, member.getMem_userid());
			pstmt.setString(3, member.getMem_pwd());
			pstmt.setString(4, member.getMem_email());
			pstmt.setString(5, member.getMem_name());
			pstmt.setString(6, member.getMem_birth());
			pstmt.setInt(7, member.getMem_gender());
			pstmt.setString(8, member.getMem_nickname());
			pstmt.setString(9, member.getMem_img());
			pstmt.setTimestamp(10, member.getJoin_date());
			pstmt.setInt(11, member.getMem_type());
			pstmt.executeUpdate();
			rs = "ok";
			
		} catch(Exception e) {
			e.printStackTrace();
			rs = "error";
		} finally {
			if(pstmt != null)
				try { pstmt.close(); } catch(SQLException ex) {}
			if(conn != null)
				try { conn.close(); } catch(SQLException ex) {}
		}
		return rs;
	}
	
	public int userCheck(String mem_userid, String mem_pwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpwd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select mem_pwd from member where mem_userid = ?");
			pstmt.setString(1, mem_userid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpwd = rs.getString("mem_pwd");
				if(dbpwd.equals(mem_pwd))
					x = 1; //인증 성공
				else
					x = 0; //비밀번호 틀림
			} else
				x = -1; //아이디 존재하지 않음
				
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException ex) {}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if(conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}
	
	public int idConfirm(String mem_userid) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = -1;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select mem_userid from member where mem_userid = ?");
			pstmt.setString(1, mem_userid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = 1; //아이디 중복
			} else {
				x = -1; //아이디 존재 안함
			}
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}
	
	public MemberDataBean getProfile(String mem_userid) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDataBean profile = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select * from member where mem_userid = ?");
			pstmt.setString(1, mem_userid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				profile = new MemberDataBean();
				profile.setMem_status(rs.getInt("mem_status"));
				profile.setMem_userid(rs.getString("mem_userid"));
				profile.setMem_pwd(rs.getString("mem_pwd"));
				profile.setMem_email(rs.getString("mem_email"));
				profile.setMem_name(rs.getString("mem_name"));
				profile.setMem_birth(rs.getString("mem_birth"));
				profile.setMem_gender(rs.getInt("mem_gender"));
				profile.setMem_nickname(rs.getString("mem_nickname"));
				profile.setMem_img(rs.getString("mem_img"));
				profile.setJoin_date(rs.getTimestamp("join_date"));
				profile.setMem_type(rs.getInt("mem_type"));
			} else {
				profile = null;
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return profile;
	}
	
}
