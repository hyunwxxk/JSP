package my.shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CategoryDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public static CategoryDao instance = new CategoryDao();
	
	public static CategoryDao getInstance() {
		return instance;
	}
	
	private CategoryDao() {
		
	}
	
	private Connection getConnection() throws Exception{
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:comp/env"); // xml 안의 설정 정보가 java:comp/env 폴더에 있음
		DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB"); // xml의 네임
		conn = ds.getConnection();
		System.out.println("conn:"+conn);
		return conn;
	} // getConnection
	
	public int insertCategory(CategoryBean cdto) throws Exception {
		Connection conn = getConnection();

		int cnt = -1;
		String sql = "insert into category values(catseq.nextval, ?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, cdto.getCode());
			ps.setString(2, cdto.getCname());
			
			cnt = ps.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}//insertCategory
	
	public ArrayList<CategoryBean> getAllCategory() throws Exception {
		ArrayList<CategoryBean> lists = new ArrayList<CategoryBean>();
		Connection conn = getConnection();
		String sql = "select * from category order by cnum";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				CategoryBean cdto = new CategoryBean();
				cdto.setCnum(rs.getInt("cnum"));
				cdto.setCode(rs.getString("code"));
				cdto.setCname(rs.getString("cname"));
				lists.add(cdto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return lists;
	}//getAllCategory
	
	public int deleteCategory(int cnum) throws Exception {
		int cnt = -1;
		String sql = "delete from category where cnum=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, cnum);
		cnt = ps.executeUpdate();
		return cnt;
	}
	
}
