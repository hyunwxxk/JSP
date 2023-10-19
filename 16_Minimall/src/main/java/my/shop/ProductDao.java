package my.shop;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class ProductDao {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static ProductDao instance = new ProductDao();

	public static ProductDao getInstance() {
		return instance;
	}

	private ProductDao() {

	}

	private Connection getConnection() throws Exception{
		Context initContext = new InitialContext();
		Context envContext = (Context)initContext.lookup("java:comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
		conn = ds.getConnection();
		System.out.println("conn:"+conn);
		return conn;
	}

	public int insertProduct(MultipartRequest mr) throws Exception{
		Connection conn = getConnection();
		int cnt = -1;
		String sql = "insert into product values(catprod.nextval,?,?,?,?,?,?,?,?,?,?)";
		ps = conn.prepareStatement(sql);

		String pcategory_fk = mr.getParameter("pcategory_fk");
		pcategory_fk += mr.getParameter("pcode"); // pcategory_fk = 카테고리 + 상품코드가 연결

		ps.setString(1, mr.getParameter("pname"));
		ps.setString(2, pcategory_fk);
		ps.setString(3, mr.getParameter("pcompany"));
		ps.setString(4, mr.getFilesystemName("pimage")); // image만 getFilesystemName로 가져옴
		ps.setInt(5, Integer.parseInt(mr.getParameter("pqty")));
		ps.setInt(6, Integer.parseInt(mr.getParameter("price")));
		ps.setString(7, mr.getParameter("pspec"));
		ps.setString(8, mr.getParameter("pcontents"));
		ps.setInt(9, Integer.parseInt(mr.getParameter("point")));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date(); // 오늘 날짜 정보를 today에 넣음
		String pinputdate = sdf.format(today);
		ps.setString(10, pinputdate);

		cnt = ps.executeUpdate();

		return cnt;
	}

	public ArrayList<ProductBean> getAllProducts() throws Exception{
		conn = getConnection();
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();

		String sql = "select * from product order by pnum";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();

		lists = makeArrayList(rs);

		return lists;
	}

	public ArrayList<ProductBean> makeArrayList(ResultSet rs) throws Exception{
		
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();

		while(rs.next()) {
			int pnum = rs.getInt("pnum");
			String pname = rs.getString("pname");
			String pcategory_fk = rs.getString("pcategory_fk");
			String pcompany = rs.getString("pcompany");
			String pimage = rs.getString("pimage"); // 이미지의 이름을 챙김
			int pqty = rs.getInt("pqty");
			int price = rs.getInt("price");
			String pspec = rs.getString("pspec");
			String pcontents = rs.getString("pcontents");
			int point = rs.getInt("point");
			String pinputdate = rs.getString("pinputdate");

			ProductBean pb = new ProductBean();

			pb.setPnum(pnum);
			pb.setPname(pname);
			pb.setPcategory_fk(pcategory_fk);
			pb.setPcompany(pcompany);
			pb.setPimage(pimage);
			pb.setPqty(pqty);
			pb.setPrice(price);
			pb.setPspec(pspec);
			pb.setPcontents(pcontents);
			pb.setPoint(point);
			pb.setPinputdate(pinputdate);

			lists.add(pb);
		} // while
		return lists;
	} // makeArrayList
	
	public int deleteProduct(int pnum) throws Exception {
		Connection conn = getConnection();
		int cnt = -1;
		String sql = "delete from product where pnum=?";

			ps = conn.prepareStatement(sql);
			ps.setInt(1, pnum);

			cnt = ps.executeUpdate();

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
	}//selectProdNum

	public int updateProduct(MultipartRequest mr, String img ) throws Exception{
		conn = getConnection();
		int cnt = -1;
		String sql = "update product set pname=?, pcompany=?, pimage=?, pqty=?, price=?, pspec=?, pcontents=?, point=? where pnum=?";

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

		return cnt;
	}//updateProduct
	
}
