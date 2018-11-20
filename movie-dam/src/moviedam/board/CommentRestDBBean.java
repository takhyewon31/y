package moviedam.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentRestDBBean {
	private static CommentRestDBBean instance = new CommentRestDBBean();

	public static CommentRestDBBean getInstance() {
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/miso");
		return ds.getConnection();
	}

	public void insertComment(CommentRestDataBean cmt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "";
		int number = 0;
		int cmt_id = cmt.getCmt_id();
		int cmt_parent = cmt.getCmt_parent();
		int cmt_restep = cmt.getCmt_restep();
		int cmt_relevel = cmt.getCmt_relevel();

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select max(cmt_id) from comment_rest");
			rs = pstmt.executeQuery();

			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			if (cmt_id != 0) {
				sql = "update comment_rest set cmt_restep = cmt_restep + 1 ";
				sql += "where cmt_parent = ? and cmt_restep > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cmt_parent);
				pstmt.setInt(2, cmt_restep);
				pstmt.executeUpdate();
				cmt_restep = cmt_restep + 1;
				cmt_relevel = cmt_relevel + 1;
			} else {
				cmt_parent = number;
				cmt_restep = 0;
				cmt_relevel = 0;
			}

			sql = "insert into comment_rest(cmt_writer,cmt_content,cmt_date,cmt_ref,";
			sql += "cmt_parent,cmt_restep,cmt_relevel) values(?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cmt.getCmt_writer());
			pstmt.setString(2, cmt.getCmt_content());
			pstmt.setTimestamp(3, cmt.getCmt_date());
			pstmt.setInt(4, cmt.getCmt_ref());
			pstmt.setInt(5, cmt_parent);
			pstmt.setInt(6, cmt_restep);
			pstmt.setInt(7, cmt_relevel);
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
	
	public int getCommentCount(int cmt_ref) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		int x = 0;
		try {
			conn = getConnection();

			sql = "select count(*) from comment_rest where cmt_ref=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cmt_ref);
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

	public ArrayList<CommentRestDataBean> getComments(int cmt_ref) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<CommentRestDataBean> commentList = null;

		try {
			conn = getConnection();

			String sql = "select * from comment_rest where cmt_ref like '" + cmt_ref + "'order by cmt_parent desc";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				commentList = new ArrayList<CommentRestDataBean>();
				do {
					CommentRestDataBean comment = new CommentRestDataBean();
					comment.setCmt_id(rs.getInt("cmt_id"));
					comment.setCmt_writer(rs.getString("cmt_writer"));
					comment.setCmt_content(rs.getString("cmt_content"));
					comment.setCmt_date(rs.getTimestamp("cmt_date"));
					comment.setCmt_ref(rs.getInt("cmt_ref"));
					comment.setCmt_parent(rs.getInt("cmt_parent"));
					comment.setCmt_restep(rs.getInt("cmt_restep"));
					comment.setCmt_relevel(rs.getInt("cmt_relevel"));
					
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
	
	public CommentRestDataBean getComment(int cmt_id) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        CommentRestDataBean content=null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select * from comment_rest where cmt_id = ?");
            pstmt.setInt(1, cmt_id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	content = new CommentRestDataBean();
            	content.setCmt_id(rs.getInt("cmt_id"));
            	content.setCmt_ref(rs.getInt("cmt_ref"));
            	content.setCmt_writer(rs.getString("cmt_writer"));
            	content.setCmt_content(rs.getString("cmt_content"));
            	content.setCmt_date(rs.getTimestamp("cmt_date"));
            	content.setCmt_restep(rs.getInt("cmt_restep"));
            	content.setCmt_relevel(rs.getInt("cmt_relevel"));
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return content;
	}
	
	public int deleteComment(int cmt_id, String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbwriter = "";
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select cmt_writer from comment_rest where cmt_id=?");
			pstmt.setInt(1, cmt_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbwriter = rs.getString("cmt_writer");
				if (dbwriter.equals(id)) {
					pstmt = conn.prepareStatement("delete from comment_rest where cmt_id=?");
					pstmt.setInt(1, cmt_id);
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

	public int updateComment(CommentRestDataBean content) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from comment_rest where cmt_id=?");
			pstmt.setInt(1, content.getCmt_id());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				sql = "update comment_rest set cmt_content=? where cmt_id=?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, content.getCmt_content());
				pstmt.setInt(2, content.getCmt_id());
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
}
