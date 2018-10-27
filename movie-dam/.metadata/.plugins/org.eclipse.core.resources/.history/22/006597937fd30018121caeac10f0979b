package moviedam.debate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ChanbanDBBean {
	
	private static ChanbanDBBean instance = new ChanbanDBBean();

	public static ChanbanDBBean getInstance() {
		return instance;
	}

	private ChanbanDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/miso");
		return ds.getConnection();
	}

	// chanban테이블에 글을 추가(insert문)<=writePro.jsp페이지에서 사용
	public void insertChanban(ChanbanDataBean cb) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		try {
			conn = getConnection();
			sql = "insert into chanban values(?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb.getCb_id());
			pstmt.setString(2, cb.getCb_writer());
			pstmt.setString(3, cb.getCb_title());
			pstmt.setString(4, cb.getCb_content());
			pstmt.setTimestamp(5, cb.getReg_date());
			pstmt.setInt(6, cb.getCb_hits());
			pstmt.setString(7, cb.getCb_file());
			pstmt.setString(8, cb.getCb_type());

			pstmt.executeUpdate();
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
	}
	
	// chanban테이블에 저장된 전체글의 수를 얻어냄(select문)<=list.jsp에서 사용
	public int getChanbanCount(String option, String search) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();
			
			if (option == null) {
				pstmt = conn.prepareStatement("select count(*) from chanban");
			} else if (option.equals("all")) {
				pstmt = conn.prepareStatement("select count(*) from chanban where cb_title LIKE '%" + search + "%' or cb_content LIKE '%" + search + "%' or cb_writer LIKE '%" + search + "%'");
			} else if (option.equals("cb_title")) {
				pstmt = conn.prepareStatement("select count(*) from chanban where cb_title LIKE '%" + search + "%'");
			} else if (option.equals("cb_content")) {
				pstmt = conn.prepareStatement("select count(*) from chanban where cb_content LIKE '%" + search + "%'");
			} else if (option.equals("cb_writer")) {
				pstmt = conn.prepareStatement("select count(*) from chanban where cb_writer LIKE '%" + search + "%'");
			}
				
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
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
	
	// 글의 목록을 가져옴
	public List<ChanbanDataBean> getChanbans(int start, int end, String option, String search) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		List<ChanbanDataBean> chanbanList = null;
		try {
			conn = getConnection();
			String sql = "select * from chanban ";
			
			if (option == null) {
				pstmt = conn.prepareStatement(sql += "order by cb_id desc limit ?,? ");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			} else if (option.equals("all")) {
				pstmt = conn.prepareStatement(sql += "where cb_title LIKE '%" + search + "%' or cb_content LIKE '%" + search + "%' or cb_writer LIKE '%" + search + "%' order by cb_id desc limit ?,?");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			} else if (option.equals("cb_title")) {
				pstmt = conn.prepareStatement(sql += "where cb_title LIKE '%" + search + "%' order by cb_id desc limit ?,? ");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			} else if (option.equals("cb_content")) {
				pstmt = conn.prepareStatement(
						sql += "where cb_content LIKE '%" + search + "%' order by cb_id desc limit ?,? ");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			} else if (option.equals("cb_writer")) {
				pstmt = conn.prepareStatement(
						sql += "where cb_writer LIKE '%" + search + "%' order by cb_id desc limit ?,? ");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			}			

			rs = pstmt.executeQuery();

			if (rs.next()) {
				chanbanList = new ArrayList<ChanbanDataBean>(end);
				do {
					ChanbanDataBean chanban = new ChanbanDataBean();
					chanban.setCb_id(rs.getInt("cb_id"));
					chanban.setCb_writer(rs.getString("cb_writer"));
					chanban.setCb_title(rs.getString("cb_title"));
					chanban.setCb_content(rs.getString("cb_content"));
					chanban.setReg_date(rs.getTimestamp("reg_date"));
					chanban.setCb_hits(rs.getInt("cb_hits"));
					chanban.setCb_file(rs.getString("cb_file"));
					chanban.setCb_type(rs.getString("cb_type"));
					
					chanbanList.add(chanban);
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
		return chanbanList;
	}

	public ArrayList<ChanbanDataBean> getTopChanbans() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ChanbanDataBean> chanbanList = null;

		try {
			conn = getConnection();

			String sql = "select * from chanban order by cb_hits desc LIMIT 0, 10 ";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				chanbanList = new ArrayList<ChanbanDataBean>();
				do {
					ChanbanDataBean chanban = new ChanbanDataBean();
					chanban.setCb_id(rs.getInt("cb_id"));
					chanban.setCb_writer(rs.getString("cb_writer"));
					chanban.setCb_title(rs.getString("cb_title"));
					chanban.setCb_content(rs.getString("cb_content"));
					chanban.setReg_date(rs.getTimestamp("reg_date"));
					chanban.setCb_hits(rs.getInt("cb_hits"));
					chanban.setCb_file(rs.getString("cb_file"));
					chanban.setCb_type(rs.getString("cb_type"));

					chanbanList.add(chanban);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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
		return chanbanList;
	}

	// 글의 내용을 보기(1개의 글)(select문)<=content.jsp페이지에서 사용
	public ChanbanDataBean getChanban(int cb_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ChanbanDataBean chanban = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update chanban set cb_hits=cb_hits+1 where cb_id = ?");
			pstmt.setInt(1, cb_id);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("select * from chanban where cb_id = ?");
			pstmt.setInt(1, cb_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				chanban = new ChanbanDataBean();
				chanban.setCb_id(rs.getInt("cb_id"));
				chanban.setCb_writer(rs.getString("cb_writer"));
				chanban.setCb_title(rs.getString("cb_title"));
				chanban.setCb_content(rs.getString("cb_content"));
				chanban.setReg_date(rs.getTimestamp("reg_date"));
				chanban.setCb_hits(rs.getInt("cb_hits"));
				chanban.setCb_file(rs.getString("cb_file"));
				chanban.setCb_type(rs.getString("cb_type"));
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
		return chanban;
	}

	// 글 수정폼에서 사용할 글의 내용(1개의 글)(select문)<=updateForm.jsp에서 사용
	public ChanbanDataBean updateGetChanban(int cb_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ChanbanDataBean chanban = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from chanban where cb_id = ?");
			pstmt.setInt(1, cb_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				chanban = new ChanbanDataBean();
				chanban.setCb_id(rs.getInt("cb_id"));
				chanban.setCb_writer(rs.getString("cb_writer"));
				chanban.setCb_title(rs.getString("cb_title"));
				chanban.setCb_content(rs.getString("cb_content"));
				chanban.setReg_date(rs.getTimestamp("reg_date"));
				chanban.setCb_hits(rs.getInt("cb_hits"));
				chanban.setCb_file(rs.getString("cb_file"));
				chanban.setCb_type(rs.getString("cb_type"));
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
		return chanban;
	}
	
	//글 수정처리에서 사용(update문)<=updatePro.jsp에서 사용
	public int updateChanban(ChanbanDataBean chanban,String mem_userid) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbuserid = "";
		String sql = "";
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select cb_writer from chanban where cb_id = ?");
			pstmt.setInt(1, chanban.getCb_id());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbuserid = rs.getString("cb_writer");
				if (dbuserid.equals(mem_userid)) {
					sql = "update chanban set cb_content=?,cb_title=?,cb_file=?,cb_type=? where cb_id =?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, chanban.getCb_content());
					pstmt.setString(2, chanban.getCb_title());
					pstmt.setString(3, chanban.getCb_file());
					pstmt.setString(4, chanban.getCb_type());
					pstmt.setInt(5, chanban.getCb_id());
					pstmt.executeUpdate();
					x = 1;
				} else {
					x = 0;
				}
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
	
	// 글삭제처리시 사용(delete문)<=deletePro.jsp페이지에서 사용
	public int deleteChanban(int cb_id, String mem_userid) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbuserid = "";
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select cb_writer from chanban where cb_id = ?");
			pstmt.setInt(1, cb_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbuserid = rs.getString("cb_writer");
				if (dbuserid.equals(mem_userid)) {
					pstmt = conn.prepareStatement("delete from chanban where cb_id=?");
					pstmt.setInt(1, cb_id);
					pstmt.executeUpdate();
					x = 1;
				} else {
					x = 0;
				}
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

	
}