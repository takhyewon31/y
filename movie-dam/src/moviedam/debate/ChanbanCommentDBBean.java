package moviedam.debate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ChanbanCommentDBBean {

	private static ChanbanCommentDBBean instance = new ChanbanCommentDBBean();

	public static ChanbanCommentDBBean getInstance() {
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/miso");
		return ds.getConnection();
	}

	public void insertChanbanCmt(ChanbanCommentDataBean cmt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";
		int number = 0;
		int cb_cmt_id = cmt.getCb_cmt_id();
		int cb_cmt_group = cmt.getCb_cmt_group();
		int cb_cmt_step = cmt.getCb_cmt_step();
		int cb_cmt_level = cmt.getCb_cmt_level();

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(cb_cmt_id) from cb_comment");
			rs = pstmt.executeQuery();

			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			if (cb_cmt_id != 0) {
				sql = "update cb_comment set cb_cmt_step = cb_cmt_step + 1 ";
				sql += "where cb_cmt_group = ? and cb_cmt_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cb_cmt_group);
				pstmt.setInt(2, cb_cmt_step);
				pstmt.executeUpdate();
				cb_cmt_step = cb_cmt_step + 1;
				cb_cmt_level = cb_cmt_level + 1;
			} else {
				cb_cmt_group = number;
				cb_cmt_step = 0;
				cb_cmt_level = 0;
			}

			sql = "insert into cb_comment(cb_cmt_writer,cb_cmt_content,cb_cmt_date,cb_cmt_ref,";
			sql += "cb_cmt_group,cb_cmt_step,cb_cmt_level,cb_cmt_type) values(?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cmt.getCb_cmt_writer());
			pstmt.setString(2, cmt.getCb_cmt_content());
			pstmt.setTimestamp(3, cmt.getCb_cmt_date());
			pstmt.setInt(4, cmt.getCb_cmt_ref());
			pstmt.setInt(5, cb_cmt_group);
			pstmt.setInt(6, cb_cmt_step);
			pstmt.setInt(7, cb_cmt_level);
			pstmt.setString(8, cmt.getCb_cmt_type());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
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
	
	public int getChanbanCmtCount(int cb_cmt_ref) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		int x = 0;
		try {
			conn = getConnection();

			sql = "select count(*) from cb_comment where cb_cmt_ref=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb_cmt_ref);
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

	public int getChanbanProCount(int cb_cmt_ref) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		int x = 0;
		try {
			conn = getConnection();

			sql = "select count(*) from cb_comment where cb_cmt_ref=? and cb_cmt_type='찬성' and cb_cmt_step =0";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb_cmt_ref);
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
	
	public int getChanbanConCount(int cb_cmt_ref) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		int x = 0;
		try {
			conn = getConnection();

			sql = "select count(*) from cb_comment where cb_cmt_ref=? and cb_cmt_type='반대' and cb_cmt_step =0";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb_cmt_ref);
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
	
	public ArrayList<ChanbanCommentDataBean> getChanbanCmts(int cb_cmt_ref) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ChanbanCommentDataBean> commentList = null;

		try {
			conn = getConnection();

			String sql = "select * from cb_comment where cb_cmt_ref like '" + cb_cmt_ref + "'order by cb_cmt_group desc";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				commentList = new ArrayList<ChanbanCommentDataBean>();
				do {
					ChanbanCommentDataBean comment = new ChanbanCommentDataBean();
					comment.setCb_cmt_id(rs.getInt("cb_cmt_id"));
					comment.setCb_cmt_writer(rs.getString("cb_cmt_writer"));
					comment.setCb_cmt_content(rs.getString("cb_cmt_content"));
					comment.setCb_cmt_date(rs.getTimestamp("cb_cmt_date"));
					comment.setCb_cmt_ref(rs.getInt("cb_cmt_ref"));
					comment.setCb_cmt_group(rs.getInt("cb_cmt_group"));
					comment.setCb_cmt_step(rs.getInt("cb_cmt_step"));
					comment.setCb_cmt_level(rs.getInt("cb_cmt_level"));
					comment.setCb_cmt_type(rs.getString("cb_cmt_type"));
					
					commentList.add(comment);
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
		return commentList;
	}
	
	public ChanbanCommentDataBean getChanbanCmt(int cb_cmt_id) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ChanbanCommentDataBean comment=null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select * from cb_comment where cb_cmt_id = ?");
            pstmt.setInt(1, cb_cmt_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	comment = new ChanbanCommentDataBean();
            	comment.setCb_cmt_id(rs.getInt("cb_cmt_id"));
            	comment.setCb_cmt_ref(rs.getInt("cb_cmt_ref"));
            	comment.setCb_cmt_writer(rs.getString("cb_cmt_writer"));
            	comment.setCb_cmt_content(rs.getString("cb_cmt_content"));
            	comment.setCb_cmt_date(rs.getTimestamp("cb_cmt_date"));
            	comment.setCb_cmt_step(rs.getInt("cb_cmt_step"));
            	comment.setCb_cmt_level(rs.getInt("cb_cmt_level"));
            	comment.setCb_cmt_type(rs.getString("cb_cmt_type"));
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return comment;
	}
	
	public int deleteChanbanCmt(int cb_cmt_id, String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbwriter = "";
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select cb_cmt_writer from cb_comment where cb_cmt_id=?");
			pstmt.setInt(1, cb_cmt_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbwriter = rs.getString("cb_cmt_writer");
				if (dbwriter.equals(id)) {
					pstmt = conn.prepareStatement("delete from cb_comment where cb_cmt_id=?");
					pstmt.setInt(1, cb_cmt_id);
					pstmt.executeUpdate();
					x = 1; 
				} else
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

	public int updateChanbanCmt(ChanbanCommentDataBean comment) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from cb_comment where cb_cmt_id=?");
			pstmt.setInt(1, comment.getCb_cmt_id());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				sql = "update cb_comment set cb_cmt_content=? where cb_cmt_id=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, comment.getCb_cmt_content());
				pstmt.setInt(2, comment.getCb_cmt_id());
				pstmt.executeUpdate();
				x = 1;
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
	
	public String getLike_type (int cb_id, String mem_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String type = "";
		try {
			conn = getConnection();
			
			sql = "select cb_like_type from chanban_like where cb_id = ? and mem_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb_id);
			pstmt.setString(2, mem_id);
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
	
	public String insertLike(ChanbanlikeDataBean like) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String ltype = "";
		try {
			
			conn = getConnection();
			
			sql = "select * from chanban_like where cb_id = ? and mem_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, like.getCb_id());
			pstmt.setString(2, like.getMem_id());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String type = like.getCb_like_type();
				if(type.equals("Y")) {
					sql = "insert into chanban_like values (?, ?, ?) on duplicate key update cb_like_type = 'N'";
				} else if(type.equals("N")){
					sql = "insert into chanban_like values (?, ?, ?) on duplicate key update cb_like_type = 'Y'";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, like.getCb_id());
				pstmt.setString(2, like.getMem_id());
				pstmt.setString(3, like.getCb_like_type());
				
			} else {
				sql = "insert into chanban_like values (?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, like.getCb_id());
				pstmt.setString(2, like.getMem_id());
				pstmt.setString(3, "Y");
			}			
			pstmt.executeUpdate();
			
			
			sql = "select cb_like_type from chanban_like where cb_id = ? and mem_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, like.getCb_id());
			pstmt.setString(2, like.getMem_id());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				ltype = rs.getString(1);
			} else {
				ltype = "N";
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
		return ltype;
	}

	public int getlikeCount(int cb_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		int x = 0;
		try {
			conn = getConnection();

			sql = "select count(*) from chanban_like where cb_id=? and cb_like_type = 'Y'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb_id);
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

}