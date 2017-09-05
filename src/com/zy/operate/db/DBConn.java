package com.zy.operate.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConn {
	private Connection conn;
	public void connDB(){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/sx","root","970112");
			System.out.println("数据库连接成功");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void insertDB(String company,String imgPath,int price){
		connDB();
		String sql="insert into t_bidding(comName,imgPath,price) values(?,?,?)";
		PreparedStatement pst;
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, company);
			pst.setString(2, imgPath);
			pst.setInt(3, price);
			pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
	public String getBiddingInfo(){
		connDB();
		String comName = null,
				imgPath = null,
				info = null;
		String sql="select comName,imgPath from t_bidding where price in (select MAX(price) from t_bidding)";
		try {
			PreparedStatement pst=conn.prepareStatement(sql);
			ResultSet res=pst.executeQuery();
			while(res.next()){
				comName=res.getString(1);
				imgPath=res.getString(2);
			}
			info=comName+"|"+"img/"+imgPath;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return info;
	}
}
