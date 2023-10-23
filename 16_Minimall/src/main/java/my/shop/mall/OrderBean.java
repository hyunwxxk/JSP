package my.shop.mall;

public class OrderBean {
	// shopping_list.jsp => 고객명 아이디 상품명 수량 금액
	// 테이블이랑 다르게 만든 이유 : 필요한 정보를 Vector에 넣기 위해
	private String mname;
	private String mid;
	private String pname;
	private int qty;
	private int amount;
	
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getQty() { 
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
}
