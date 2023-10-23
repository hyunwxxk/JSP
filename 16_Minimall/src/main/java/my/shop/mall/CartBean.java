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
		
		for(int i=0;i<clist.size();i++) {
			int cPnum = clist.get(i).getPnum(); // 장바구니에 들어가있는 pnum의 번호를 알아냄
			if (cPnum == pnum) { /* 장바구니에 들어가있는 pnum과 추가하려는 pnum이 같은지 */
				int cPqty = clist.get(i).getPqty(); // 장바구니에 담겨있는 주문수량을 가져옴
				clist.get(i).setPqty(cPqty+oqty); // 기존상품에 수량에 주문수량을 더함
				return; // 기존상품에 추가를 하고 아래로 내려오면 새로 추가를 다시 하게 되어 밑으로 내려가지 않도록 return을 사용
			} // if
		} // for
		
		
		pb.setPqty(oqty); // 주문수량을 추가해서
		clist.add(pb); // 장바구니에 담음
		System.out.println("clist.size() : " + clist.size()); /* clist의 갯수 */
		
		for(int i=0;i<clist.size();i++) {
			System.out.println(clist.get(i).getPnum());
			System.out.println(clist.get(i).getPname());
			System.out.println(clist.get(i).getPqty());
		}
		
	} // addProduct
	
	public Vector<ProductBean> getAllProducts() { 
		return clist;
	} // getAllProducts
	
	public void setEdit(String pnum, String oqty) { /* 내가 넘긴 상품을 주문수량만큼 수정 */
		
		for (ProductBean pb : clist) { /* clist를 pb에 넣음 */
			if(pb.getPnum() == Integer.parseInt(pnum)) { 
				if(Integer.parseInt(oqty) == 0) { // 장바구니에 담은 수량이 0개 이면
					clist.removeElement(pb); // 장바구니에서 내가 보고 있는 상품을 지워라
					break;
				}else {
					pb.setPqty(Integer.parseInt(oqty));
					break;
				}
			}
		}
		
	} // setEdit
	
	public void deleteByPnum(int pnum) {
		for (ProductBean pb : clist) { /* clist에 값을 pb에 넣어라 */
			if (pb.getPnum() == pnum) { /* 장바구니 상품과 같은 번호가 있으면 지워라 */
				clist.removeElement(pb);
				break;
			}
		}
	}
	
	public void removeAllProducts() {
		clist.removeAllElements(); /* clist가 관리하는 장바구니 모든 상품 요소들을 삭제 */
	}
	
}
