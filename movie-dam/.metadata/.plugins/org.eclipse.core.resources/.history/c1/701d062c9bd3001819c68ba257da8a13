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

import moviedam.member.MemberDataBean;

public class BoardDBBean {
	
    private static BoardDBBean instance = new BoardDBBean();
    public static BoardDBBean getInstance() {
        return instance;
    }
    
    private BoardDBBean() {}
    
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/miso");
        return ds.getConnection();
    }
     
    public BoardDataBean getBoard(int board_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDataBean board = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select * from board where board_id = ?");
			pstmt.setInt(1, board_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardDataBean();
				board.setBoard_id(rs.getInt("board_id"));
				board.setBoard_name(rs.getString("board_name"));
			} else {
				board = null;
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return board;
    }

}