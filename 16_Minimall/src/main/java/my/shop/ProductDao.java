package my.shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class ProductDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public static ProductDao instance = new ProductDao();
	public static ProductDao getInstance() {
		return instance;
	}

	private ProductDao() {

	}

	private Connection getConnection() throws Exception{
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:comp/env"); // xml 안의 설정 정보가 java:comp/env 폴더에 있음
		DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB"); // xml의 네임
		conn = ds.getConnection();
		System.out.println("conn:"+conn);
		return conn;
	} // getConnection

	public int insertProduct(MultipartRequest mr) throws Exception {
		conn = getConnection();

		String sql = "insert into product values(catprod.nextval,?,?,?,?,?,?,?,?,?,?)";
		int cnt = -1;

		ps = conn.prepareStatement(sql);

		String pcategory_fk = mr.getParameter("pcategory_fk"); // 뭐가?
		pcategory_fk += mr.getParameter("pcode"); // pcategory_fk = 카테고리+상품코드 

		ps.setString(1, mr.getParameter("pname"));
		ps.setString(2, pcategory_fk);
		ps.setString(3, mr.getParameter("pcompany"));
		ps.setString(4, mr.getFilesystemName("pimage"));
		ps.setInt(5, Integer.parseInt(mr.getParameter("pqty")));
		ps.setInt(6, Integer.parseInt(mr.getParameter("price")));
		ps.setString(7, mr.getParameter("pspec"));
		ps.setString(8, mr.getParameter("pcontents"));
		ps.setInt(9, Integer.parseInt(mr.getParameter("point")));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		String pinputdate = sdf.format(today);
		ps.setString(10, pinputdate);

		cnt = ps.executeUpdate();

		return cnt;
	}//insertProduct

	public ArrayList<ProductBean> getAllProducts() throws Exception {
		conn = getConnection();
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		String sql = "select * from product order by pnum";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			lists = makeArrayList(rs);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return lists;
	}//getAllProducts

	public ArrayList<ProductBean> makeArrayList(ResultSet rs) throws SQLException{
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		while(rs.next()) {
			ProductBean pb = new ProductBean();
			pb.setPnum(rs.getInt("pnum"));
			pb.setPcategory_fk(rs.getString("pcategory_fk"));
			pb.setPname(rs.getString("pname"));
			pb.setPcompany(rs.getString("pcompany"));
			pb.setPimage(rs.getString("pimage")); // 검정양복.jpg
			pb.setPqty(rs.getInt("pqty"));
			pb.setPrice(rs.getInt("price"));
			pb.setPspec(rs.getString("pspec"));
			pb.setPcontents(rs.getString("pcontents"));
			pb.setPoint(rs.getInt("point"));
			pb.setPinputdate(rs.getString("pinputdate"));

			lists.add(pb);
		}//while

		return lists;
	}//makeArrayList

	public int deleteProduct(int pnum) throws Exception {
		Connection conn = getConnection();
		int cnt = -1;
		String sql = "delete from product where pnum=?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pnum);

			cnt = ps.executeUpdate();

		} catch(Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}//deleteProduct

	public ProductBean selectProdNum(int pnum) throws Exception{
		conn = getConnection();
		ProductBean pb = null;
		String sql = "select * from product where pnum=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, pnum);
		rs = ps.executeQuery();
		if(rs.next()) {
			pb = new ProductBean();
			pb.setPnum(rs.getInt("pnum"));
			pb.setPname(rs.getString("pname"));
			pb.setPcategory_fk(rs.getString("pcategory_fk"));
			pb.setPcompany(rs.getString("pcompany"));
			pb.setPimage(rs.getString("pimage"));
			pb.setPqty(rs.getInt("pqty"));
			pb.setPrice(rs.getInt("price"));
			pb.setPspec(rs.getString("pspec"));
			pb.setPcontents(rs.getString("pcontents"));
			pb.setPoint(rs.getInt("point"));
			pb.setPinputdate(rs.getString("pinputdate"));

		}
		System.out.println("pb:" + pb);
		return pb;
	} //selectProdNum

	public int updateProduct(MultipartRequest mr, String img ) throws Exception{
		conn = getConnection();
		int cnt = -1;
		String sql = "update product set pname=?, pcompany=?, pimage=?, pqty=?, price=?, pspec=?, pcontents=?, point=? where pnum=?";

		try {

			ps = conn.prepareStatement(sql);

			ps.setString(1,mr.getParameter("pname"));
			ps.setString(2,mr.getParameter("pcompany"));
			ps.setString(3,img);
			ps.setInt(4,Integer.parseInt(mr.getParameter("pqty")));				
			ps.setInt(5,Integer.parseInt(mr.getParameter("price")));
			ps.setString(6,mr.getParameter("pspec"));
			ps.setString(7,mr.getParameter("pcontents"));
			ps.setInt(8,Integer.parseInt(mr.getParameter("point")));
			ps.setInt(9,Integer.parseInt(mr.getParameter("pnum")));

			cnt = ps.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		}
		
		return cnt;
	}//updateProduct
	
	public ArrayList<ProductBean> getSelectByPspec(String spec) throws Exception{
		conn = getConnection();
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		
		String sql = "select * from product where pspec=?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, spec);
		rs = ps.executeQuery();
		lists = makeArrayList(rs);
		return lists;
		
	}//getSelectByPspec
	
	public ArrayList<ProductBean> getSelectByCategory(String code) throws Exception {
		conn = getConnection();
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		String sql = "select * from product where pcategory_fk like ?";
		ProductBean pb = null;
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, code+"%");
		
		rs = ps.executeQuery();
		lists = makeArrayList(rs);
		return lists;
	}//getSelectByCategory
	
	public ProductBean getSelectByPnum(int pnum) throws Exception {
		Connection conn = getConnection();
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		
		String sql="select * from product where pnum = ?";
		ProductBean pb = new ProductBean();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pnum);
			
			rs = ps.executeQuery();
//			if(rs.next()) {
//				pdto.setPnum(rs.getInt("pnum"));
//				pdto.setPname(rs.getString("pname"));
//				pdto.setPrice(rs.getInt("price"));
//				pdto.setPoint(rs.getInt("point"));
//				pdto.setPimage(rs.getString("pimage"));
//				pdto.setPcontents(rs.getString("pcontents"));
//			}
			lists = makeArrayList(rs);
			pb = lists.get(0); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return pb;
	}//getSelectByPnum
	
	public ArrayList<ProductBean> getProductByPnum(int pnum) throws Exception {
		conn = getConnection();
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		String sql = "select * from product where pnum=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pnum);
			rs = ps.executeQuery();

			lists = makeArrayList(rs);
			
		return lists;
	}
	
}






