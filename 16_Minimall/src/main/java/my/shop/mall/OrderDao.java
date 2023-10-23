package my.shop.mall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import my.shop.ProductBean;

public class OrderDao {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public OrderDao() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env"); // xml 안의 설정 정보가 java:comp/env 폴더에 있음
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB"); // xml의 네임
			conn = ds.getConnection();
			System.out.println("conn:"+conn);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // OrderDao 생성자
	
	public int insertOrder(int memno, Vector<ProductBean> cv) { /*cv에 장바구니에 담긴 상품이 들어있음*/
		int cnt = -1;
		int sum = 0;
			try {
				conn.setAutoCommit(false);
				
				for(int i=0;i<cv.size();i++) {
					String sql = "insert into orders values(orderseq.nextval,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, memno);
				ps.setInt(2, cv.get(i).getPnum());
				ps.setInt(3, cv.get(i).getPqty()); // 주문수량
				ps.setInt(4, cv.get(i).getPrice() * cv.get(i).getPqty()); /* 가격과 주문수량을 곱함 */
				
				cnt = ps.executeUpdate();
				
				}
				
				if(cnt == cv.size()) {
					conn.commit();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return cnt;
	} // insertOrder
	
	public Vector<OrderBean> getOrderList(String id) {
		Vector<OrderBean> lists = new Vector<OrderBean>();
		/* sql문 작성시 중복되는 칼럼명이 있을 경우에는 별칭 설정 */
		String sql = "select m.name mname, m.id mid, p.pname ppname, o.qty oqty, o.amount oamount\r\n"
				+ "from (members m inner join orders o on m.no = o.memno) inner join product p on o.pnum = p.pnum\r\n"
				+ "where id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				OrderBean ob = new OrderBean();
				ob.setMname(rs.getString("mname"));
				ob.setMid(rs.getString("mid"));
				ob.setPname(rs.getString("ppname"));
				ob.setQty(rs.getInt("oqty"));
				ob.setAmount(rs.getInt("oamount"));
				lists.add(ob);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("getOrderList lists.size() : " + lists.size());
		return lists;
	} // getOrderList
	
}
