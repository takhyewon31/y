package moviedam.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class RestaurantDBBean {
	private static RestaurantDBBean instance = new RestaurantDBBean();
	
	public static RestaurantDBBean getInstance() {
		return instance;
	}
	
	private RestaurantDBBean() {
		
	}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/miso");
		return ds.getConnection();
	}
	
	public void insertArticle(RestaurantDataBean article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		try {
			conn = getConnection();
			sql = "insert into restaurant values(?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getArticle_id());
			pstmt.setString(2, article.getArticle_writer());
			pstmt.setString(3, article.getArticle_title());
			pstmt.setString(4, article.getArticle_content());
			pstmt.setTimestamp(5, article.getReg_date());
			pstmt.setInt(6, article.getArticle_hits());
			pstmt.setInt(7, article.getArticle_gets());
			pstmt.setString(8, article.getArticle_file());
			pstmt.setString(9, article.getSearch_loc());
			pstmt.setFloat(10, article.getStart_lat());
			pstmt.setFloat(11, article.getStart_lon());
			
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
	
	public int getArticleCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select count(*) from restaurant");
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
	
	public List<RestaurantDataBean> getArticles(int start, int end, String option, String search) throws Exception {
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		List<RestaurantDataBean> articleList = null;
		try {
			conn = getConnection();
			String sql = "select * from restaurant ";
			
			if (option == null) {
				pstmt = conn.prepareStatement(sql += "order by article_id desc limit ?,? ");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			} else if (option.equals("all")) {
				pstmt = conn.prepareStatement(sql += "where article_title LIKE '%" + search + "%' or article_content LIKE '%" + search + "%' or article_writer LIKE '%" + search + "%' order by article_id desc limit ?,?");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			} else if (option.equals("article_title")) {
				pstmt = conn.prepareStatement(sql += "where article_title LIKE '%" + search + "%' order by article_id desc limit ?,? ");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			} else if (option.equals("article_content")) {
				pstmt = conn.prepareStatement(
						sql += "where article_content LIKE '%" + search + "%' order by article_id desc limit ?,? ");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			} else if (option.equals("article_writer")) {
				pstmt = conn.prepareStatement(
						sql += "where article_writer LIKE '%" + search + "%' order by article_id desc limit ?,? ");
				pstmt.setInt(1, start - 1);
				pstmt.setInt(2, end);
			}
            
			rs = pstmt.executeQuery();

			if (rs.next()) {
				articleList = new ArrayList<RestaurantDataBean>(end);
				do {
					RestaurantDataBean article = new RestaurantDataBean();
					article.setArticle_id(rs.getInt("article_id"));
					article.setArticle_writer(rs.getString("article_writer"));
					article.setArticle_title(rs.getString("article_title"));
					article.setArticle_content(rs.getString("article_content"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setArticle_hits(rs.getInt("article_hits"));
					article.setArticle_gets(rs.getInt("article_gets"));
					article.setArticle_file(rs.getString("article_file"));
					article.setSearch_loc(rs.getString("search_loc"));
					article.setStart_lat(rs.getFloat("start_lat"));
					article.setStart_lon(rs.getFloat("start_lon"));
					
					articleList.add(article);
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
		return articleList;
	}
		
	public RestaurantDataBean getArticle(int article_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RestaurantDataBean article = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update restaurant set article_hits=article_hits+1 where article_id = ?");
			pstmt.setInt(1, article_id);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("select * from restaurant where article_id = ?");
			pstmt.setInt(1, article_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				article = new RestaurantDataBean();
				article.setArticle_id(rs.getInt("article_id"));
				article.setArticle_writer(rs.getString("article_writer"));
				article.setArticle_title(rs.getString("article_title"));
				article.setArticle_content(rs.getString("article_content"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setArticle_hits(rs.getInt("article_hits"));
				article.setArticle_gets(rs.getInt("article_gets"));
				article.setArticle_file(rs.getString("article_file"));
				article.setSearch_loc(rs.getString("search_loc"));
				article.setStart_lat(rs.getFloat("start_lat"));
				article.setStart_lon(rs.getFloat("start_lon"));
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
		return article;
	}
	
	public RestaurantDataBean updateGetArticle(int article_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		RestaurantDataBean article = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from restaurant where article_id = ?");
			pstmt.setInt(1, article_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				article = new RestaurantDataBean();
				article.setArticle_id(rs.getInt("article_id"));
				article.setArticle_writer(rs.getString("article_writer"));
				article.setArticle_title(rs.getString("article_title"));
				article.setArticle_content(rs.getString("article_content"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setArticle_hits(rs.getInt("article_hits"));
				article.setArticle_gets(rs.getInt("article_gets"));
				article.setArticle_file(rs.getString("article_file"));
				article.setSearch_loc(rs.getString("search_loc"));
				article.setStart_lat(rs.getFloat("start_lat"));
				article.setStart_lon(rs.getFloat("start_lon"));
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
		return article;
	}
	
	public int updateArticle(RestaurantDataBean article,String mem_nickname) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String dbuserid = "";
		String sql = "";
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select article_writer from restaurant where article_id = ?");
			pstmt.setInt(1, article.getArticle_id());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbuserid = rs.getString("article_writer");
				if (dbuserid.equals(mem_nickname)) {
					sql = "update restaurant set article_content=?,article_title=?,article_file=? where article_id =?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getArticle_content());
					pstmt.setString(2, article.getArticle_title());
					pstmt.setString(3, article.getArticle_file());
					pstmt.setInt(4, article.getArticle_id());
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
	
	public int deleteArticle(int article_id, String mem_nickname) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbuserid = "";
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select article_writer from restaurant where article_id = ?");
			pstmt.setInt(1, article_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbuserid = rs.getString("article_writer");
				if (dbuserid.equals(mem_nickname)) {
					pstmt = conn.prepareStatement("delete from restaurant where article_id=?");
					pstmt.setInt(1, article_id);
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

	public String getLike_type (int board_id, int article_id, String mem_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String type = "";
		try {
			conn = getConnection();
			
			sql = "select like_type from article_like where board_id = ? and article_id = ? and mem_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_id);
			pstmt.setInt(2, article_id);
			pstmt.setString(3, mem_id);
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
	
	public String insertLike(ArticlelikeDataBean like) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String ltype = "";
		try {
			
			conn = getConnection();
			
			sql = "select * from article_like where board_id = ? and article_id = ? and mem_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, like.getBoard_id());
			pstmt.setInt(2, like.getArticle_id());
			pstmt.setString(3, like.getMem_id());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String type = like.getLike_type();
				if(type.equals("Y")) {
					sql = "insert into article_like values (?, ?, ?, ?) on duplicate key update like_type = 'N'";
				} else if(type.equals("N")){
					sql = "insert into article_like values (?, ?, ?, ?) on duplicate key update like_type = 'Y'";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, like.getBoard_id());
				pstmt.setInt(2, like.getArticle_id());
				pstmt.setString(3, like.getMem_id());
				pstmt.setString(4, like.getLike_type());
				
			} else {
				sql = "insert into article_like values (?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, like.getBoard_id());
				pstmt.setInt(2, like.getArticle_id());
				pstmt.setString(3, like.getMem_id());
				pstmt.setString(4, "Y");
			}			
			pstmt.executeUpdate();
			
			
			sql = "select like_type from article_like where board_id = ? and article_id = ? and mem_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, like.getBoard_id());
			pstmt.setInt(2, like.getArticle_id());
			pstmt.setString(3, like.getMem_id());
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

	public int getlikeCount(int board_id, int article_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		int x = 0;
		try {
			conn = getConnection();

			sql = "select count(*) from article_like where board_id=? and article_id=? and like_type = 'Y'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_id);
			pstmt.setInt(2, article_id);
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
