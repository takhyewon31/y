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

public class PreviewDBBean {
	private static PreviewDBBean instance = new PreviewDBBean();

	public static PreviewDBBean getInstance() {
		return instance;
	}

	private PreviewDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/miso");
		return ds.getConnection();
	}
	
	public void insertArticle(PreviewDataBean article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		try {
			conn = getConnection();
			sql = "insert into preview values(?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getArticle_id());
			pstmt.setString(2, article.getArticle_title());
			pstmt.setString(3, article.getPreview_date());
			pstmt.setString(4, article.getPreview_region());
			pstmt.setTimestamp(5, article.getReg_date());
			pstmt.setString(6, article.getOriginal_url());
			pstmt.setString(7, article.getArticle_file());
			pstmt.setString(8, article.getCinema());
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
}
