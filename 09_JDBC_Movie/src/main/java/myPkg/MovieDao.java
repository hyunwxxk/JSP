package myPkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class MovieDao {
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String dbId = "sqlid";
	String dbPw = "sqlpw";
	Connection conn = null;
	
	public MovieDao(){
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,dbId,dbPw);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<MovieBean> getAllMovies() {
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		ArrayList<MovieBean> lists = new ArrayList<MovieBean>();
		String sql = "select * from movie order by num asc";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int num = Integer.parseInt(rs.getString("num"));
				String id = rs.getString("id");
				String name = rs.getString("name");
				int age = Integer.parseInt(rs.getString("age"));
				String genre = rs.getString("genre");
				String time = rs.getString("time");
				int partner = Integer.parseInt(rs.getString("partner"));
				String memo = rs.getString("memo");
				
				MovieBean mb = new MovieBean();
				
				mb.setNum(num);
				mb.setId(id);;
				mb.setName(name);
				mb.setAge(age);
				mb.setGenre(genre);
				mb.setTime(time);
				mb.setPartner(partner);
				mb.setMemo(memo);
				
				lists.add(mb);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null) {
					ps.close();
				}
				if(rs!=null) {
					rs.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("lists.size() : " + lists.size());
		return lists;
	}
	
	public int insertData(MovieBean mb) {
		PreparedStatement ps = null;
		int cnt = -1;
		String sql = "insert into movie values(mv_seq.nextval,?,?,?,?,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getId());
			ps.setString(2, mb.getName());
			ps.setInt(3, mb.getAge());
			ps.setString(4, mb.getGenre());
			ps.setString(5, mb.getTime());
			ps.setInt(6, mb.getPartner());
			ps.setString(7, mb.getMemo());
			
			cnt = ps.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (ps != null) {
					ps.close();
				} 
				if (conn != null){
					conn.close();
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("cnt : " + cnt);
		return cnt;
	}
	
	public boolean searchId(String id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean isCheck = false;
		String sql = "select id from movie where id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				isCheck = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null) {
					ps.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return isCheck;
	}
	
	public MovieBean getMovieByNum(int num) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		MovieBean mb = null;
		
		String sql = "select * from movie where num=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, num);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				mb = new MovieBean();
				mb.setNum(rs.getInt("num"));
				mb.setId(rs.getString("id"));
				mb.setName(rs.getString("name"));
				mb.setAge(rs.getInt("age"));
				mb.setGenre(rs.getString("genre"));
				mb.setTime(rs.getString("time"));
				mb.setPartner(rs.getInt("partner"));
				mb.setMemo(rs.getString("memo"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) 
					rs.close();
				if(ps!=null)
					ps.close();
				if(conn!=null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mb;
	}
	
	public int updateData(MovieBean mb) {
		PreparedStatement ps = null;
		int cnt = -1;
		String sql = "update movie set name=?,age=?,genre=?,time=?,partner=?,memo=? where num=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getName());
			ps.setInt(2, mb.getAge());
			ps.setString(3, mb.getGenre());
			ps.setString(4, mb.getTime());
			ps.setInt(5, mb.getPartner());
			ps.setString(6, mb.getMemo());
			ps.setInt(7, mb.getNum());
			
			cnt = ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)
					ps.close();
				if(conn!=null)
					conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	public int deleteData(int num) {
		PreparedStatement ps = null;
		int cnt = -1;
		String sql = "delete from movie where num=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, num);
			
			cnt = ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return cnt;
	}
	
public int deleteCheckData(String[] rowcheck) {
		
		PreparedStatement ps = null;
		int cnt = -1;
		String sql = "delete from movie where num=?";
		for(int i=0;i<rowcheck.length-1;i++) {
			sql += " or num=?";
		}
		
		try {
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sql);
			for(int i=1;i<=rowcheck.length;i++) {
				ps.setInt(i, Integer.parseInt(rowcheck[i-1]));
			}
			cnt = ps.executeUpdate();
			conn.commit();
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		} finally {
			try {
				if(ps!=null) {
					ps.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("deleteCheckData cnt:" + cnt);
		return cnt;
	}
	
	
}
