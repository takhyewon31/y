package moviedam.debate;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import kr.co.shineware.nlp.komoran.core.analyzer.Komoran;
import kr.co.shineware.util.common.model.Pair;

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

	String indexPath = this.getClass().getResource("").getPath();
	String path = this.getClass().getResource("models-full").getPath();
	Komoran komoran = new Komoran(path);
	List<String> doc = null;
	List<List<String>> docs = null;
	File file = new File(indexPath, "word_index.txt");
	
	public HashMap<String, Double> analyzeContent(String content) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";	
		docs = new ArrayList<List<String>>();
		int docsSize = 0;
		Analyze analyze = new Analyze();
		HashMap<String, Double> map = new HashMap<String, Double>();
		
		BufferedReader reader = null;
		PrintWriter writer = null;
		try {
			conn = getConnection();

			sql = "select count(*) from chanban";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				docsSize = rs.getInt(1)+1;
			}
			
			//형태소 분석
			doc = new ArrayList<String>();
			content = content.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
			List<List<Pair<String,String>>> result = komoran.analyze(content);
			for (List<Pair<String, String>> eojeolResult : result) {
				for (Pair<String, String> wordMorph : eojeolResult) {
					System.out.println(wordMorph);
					if(wordMorph.getSecond().equals("NNP") || wordMorph.getSecond().equals("NNG"))
						doc.add(wordMorph.getFirst());
				}
					System.out.println();
			}			
		
			//index 생성 부분
			HashSet<String> docSet = new HashSet<String>(doc);
			Map<String, Integer> indexMap = new HashMap<>();
			Map<String, Integer> indexedMap = new HashMap<>();

			reader = new BufferedReader(new FileReader(file));
			String line;
			while ((line = reader.readLine()) != null) {
				System.out.println("line: " + line);	
				String[] data = line.split("=");
				if(data.length >= 2) {
					String key = data[0];
					String value = data[1];
					indexedMap.put(key, Integer.parseInt(value));
				} else {
					System.out.println("ignoring line: " + line);
				}
			}
			indexMap.putAll(indexedMap);
			
			for(String term : docSet) {			
				if(indexMap.containsKey(term)) {
					indexMap.put(term, indexMap.get(term)+1);
				} else {
					indexMap.put(term, 1);
				}
			}
			System.out.println(indexMap);
			
			//tf-idf 계산
			for(String term : doc) {
				int docsCount = indexMap.get(term);
				double tfidf = analyze.tfIdf(doc, docsCount, docsSize, term);
				map.put(term, tfidf);
				System.out.println("term:" + term + ", tf-idf:" + tfidf);
			}

			writer = new PrintWriter(new BufferedWriter(new FileWriter(file)));
			for(String key : indexMap.keySet()) {
				writer.println(key + "=" + indexMap.get(key));
				writer.flush();
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(writer != null) writer.close();
			if(reader != null) reader.close();
		}
		return map;
	}
	
	public static boolean ASC = true;
    public static boolean DESC = false;
	public static HashMap<String,Double> sortByValue(HashMap<String,Double> unsortedMap, final boolean order) {
		List<Entry<String, Double>> list = new LinkedList<Entry<String, Double>>(unsortedMap.entrySet());
		// value로 값 정렬
		Collections.sort(list, new Comparator<Entry<String,Double>>() {
			public int compare(Entry<String,Double> comp1, Entry<String,Double> comp2) {
				if(order) {
					return comp1.getValue().compareTo(comp2.getValue());
				} else {
					return comp2.getValue().compareTo(comp1.getValue());
				}
			}
		});
		// 정렬된 항목을 기반으로 linked hashmap 생성 
		HashMap<String,Double> sortedMap = new LinkedHashMap<String,Double>();
		for(Entry<String,Double> entry : list) {
			sortedMap.put(entry.getKey(), entry.getValue());
		}
		return sortedMap;
	}
	
	public void insertChanban(ChanbanDataBean cb) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";

		try {	
			String cb_tag = "";
			HashMap<String, Double> analyzedMap = analyzeContent(cb.getCb_content());
			HashMap<String, Double> sortedMap = sortByValue(analyzedMap, DESC);
			if(sortedMap.size() >= 7) { 
				List<String> top7List = new ArrayList<String>();
				List<Entry<String,Double>> sortedList = new ArrayList<Entry<String,Double>>(sortedMap.entrySet());
				List<Entry<String,Double>> topTags = sortedList.subList(0, 7);
				for(Entry<String,Double> entry : topTags) {
					top7List.add(entry.getKey());
				}
				System.out.println(top7List);
				cb_tag = String.join("|", top7List);
			} else {
				List<String> topNList = new ArrayList<String>();
				List<Entry<String,Double>> sortedList = new ArrayList<Entry<String,Double>>(sortedMap.entrySet());
				for(Entry<String,Double> entry : sortedList) {
					topNList.add(entry.getKey());
				}
				System.out.println(topNList);
				cb_tag = String.join("|", topNList);
			}
			conn = getConnection();
			sql = "insert into chanban values(?,?,?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb.getCb_id());
			pstmt.setString(2, cb.getCb_writer());
			pstmt.setString(3, cb.getCb_title());
			pstmt.setString(4, cb.getCb_movie());
			pstmt.setString(5, cb.getCb_content());
			pstmt.setString(6, cb_tag);
			pstmt.setTimestamp(7, cb.getReg_date());
			pstmt.setInt(8, cb.getCb_hits());
			pstmt.setString(9, cb.getCb_file());
			pstmt.setString(10, cb.getCb_type());

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
					chanban.setCb_movie(rs.getString("cb_movie"));
					chanban.setCb_content(rs.getString("cb_content"));
					chanban.setCb_tag(rs.getString("cb_tag"));
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
					chanban.setCb_movie(rs.getString("cb_movie"));
					chanban.setCb_content(rs.getString("cb_content"));
					chanban.setCb_tag(rs.getString("cb_tag"));
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
				chanban.setCb_movie(rs.getString("cb_movie"));
				chanban.setCb_content(rs.getString("cb_content"));
				chanban.setCb_tag(rs.getString("cb_tag"));
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
				chanban.setCb_movie(rs.getString("cb_movie"));
				chanban.setCb_content(rs.getString("cb_content"));
				chanban.setCb_tag(rs.getString("cb_tag"));
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
					String cb_tag = "";
					HashMap<String, Double> analyzedMap = analyzeContent(chanban.getCb_content());
					HashMap<String, Double> sortedMap = sortByValue(analyzedMap, DESC);
					if(sortedMap.size() >= 7) { 
						List<String> top7List = new ArrayList<String>();
						List<Entry<String,Double>> sortedList = new ArrayList<Entry<String,Double>>(sortedMap.entrySet());
						List<Entry<String,Double>> topTags = sortedList.subList(0, 7);
						for(Entry<String,Double> entry : topTags) {
							top7List.add(entry.getKey());
						}
						System.out.println(top7List);
						cb_tag = String.join("|", top7List);
					} else {
						List<String> topNList = new ArrayList<String>();
						List<Entry<String,Double>> sortedList = new ArrayList<Entry<String,Double>>(sortedMap.entrySet());
						for(Entry<String,Double> entry : sortedList) {
							topNList.add(entry.getKey());
						}
						System.out.println(topNList);
						cb_tag = String.join("|", topNList);
					}
					
					sql = "update chanban set cb_content=?,cb_tag=?,cb_title=?,cb_movie=?,cb_file=?,cb_type=? where cb_id =?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, chanban.getCb_content());
					pstmt.setString(2, cb_tag);
					pstmt.setString(3, chanban.getCb_title());
					pstmt.setString(4, chanban.getCb_movie());
					pstmt.setString(5, chanban.getCb_file());
					pstmt.setString(6, chanban.getCb_type());
					pstmt.setInt(7, chanban.getCb_id());
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