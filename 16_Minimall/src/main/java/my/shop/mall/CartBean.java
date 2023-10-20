package my.shop.mall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import my.shop.ProductBean;
import my.shop.ProductDao;

public class CartBean { // 장바구니
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	private Vector<ProductBean> clist; // 상품 정보를 담을 수 있는 clist
	
	public CartBean() {
		clist = new Vector<ProductBean>(); // clist가 관리하는 vector 장바구니 객체 생성
	} // CartBean
	
	public void addProduct(int pnum, int oqty) throws Exception{ // 장바구니에 추가하는 메서드 (pnum상품 oqty만큼 주문)
		System.out.println(pnum+"/"+oqty);
		ProductBean pb = new ProductBean();
		ProductDao pdao = ProductDao.getInstance();
		
		pb = pdao.selectProdNum(pnum);
		pb.setPqty(oqty);
		
		clist.add(pb);
		System.out.println("clist.size() : " + clist.size()); /* clist의 갯수 */
		
	} // addProduct
	
	public Vector<ProductBean> getAllProducts() { 
		return clist;
	} // getAllProducts
	
}
