package moviedam.member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FollowDBBean {
	private static FollowDBBean instance = new FollowDBBean();

	public static FollowDBBean getInstance() {
		return instance;
	}

	private FollowDBBean() {
	}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/miso");
		return ds.getConnection();
	}
	
	public String getFol_type(String mem_id, String target_mem_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String type = "";
		
		try {
			conn = getConnection();
			
			sql = "select fol_type from follow where mem_id = ? and target_mem_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			pstmt.setString(2, target_mem_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				type = rs.getString(1);
			} else {
				type = "N";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return type;
	}
	
	public String following(FollowDataBean follow) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String ftype = "";
		try {
			
			conn = getConnection();
			
			sql = "select * from follow where mem_id = ? and target_mem_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, follow.getMem_id());
			pstmt.setString(2, follow.getTarget_mem_id());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String type = follow.getFol_type();
				if(type.equals("Y")) {
					sql = "insert into follow values (?, ?, ?) on duplicate key update fol_type = 'N'";
				} else if(type.equals("N")){
					sql = "insert into follow values (?, ?, ?) on duplicate key update fol_type = 'Y'";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, follow.getMem_id());
				pstmt.setString(2, follow.getTarget_mem_id());
				pstmt.setString(3, follow.getFol_type());
				
			} else {
				sql = "insert into follow values (?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, follow.getMem_id());
				pstmt.setString(2, follow.getTarget_mem_id());
				pstmt.setString(3, "Y");
			}			
			pstmt.executeUpdate();
			
			
			sql = "select fol_type from follow where mem_id = ? and target_mem_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, follow.getMem_id());
			pstmt.setString(2, follow.getTarget_mem_id());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				ftype = rs.getString(1);
			} else {
				ftype = "N";
			}
					
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return ftype;
	}
	
	public int getFollowerCount(String mem_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		int x = 0;
		try {
			conn = getConnection();

			sql = "select count(*) from follow where target_mem_id=? and fol_type = 'Y'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
			} else {
				x = 0;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}
	
	public ArrayList<FollowDataBean> getFollowers(String mem_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ArrayList<FollowDataBean> followerList = null;
		
		try {
			conn = getConnection();
			sql = "select mem_id from follow where target_mem_id=? and fol_type = 'Y'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				followerList = new ArrayList<FollowDataBean>();
				do {
					FollowDataBean follower = new FollowDataBean();
					follower.setMem_id(rs.getString("mem_id"));

					followerList.add(follower);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return followerList;
	}
	
	public int getFollowingCount(String mem_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		int x = 0;
		try {
			conn = getConnection();

			sql = "select count(*) from follow where mem_id=? and fol_type = 'Y'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
			} else {
				x = 0;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}
	
	public ArrayList<FollowDataBean> getFollowings(String mem_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ArrayList<FollowDataBean> followingList = null;
		
		try {
			conn = getConnection();
			sql = "select target_mem_id from follow where mem_id=? and fol_type = 'Y'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				followingList = new ArrayList<FollowDataBean>();
				do {
					FollowDataBean following = new FollowDataBean();
					following.setMem_id(rs.getString("mem_id"));
					following.setTarget_mem_id(rs.getString("target_mem_id"));
					following.setFol_type(rs.getString("fol_type"));

					followingList.add(following);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return followingList;
	}
}
