package com.zy.bidder.bidding;

import com.zy.operate.db.DBConn;

public class Bidding {
	public void insertBidding(String company,String imgPath,int price){
		System.out.println("Bidding insertBidding is start...");
		System.out.println(company+"***"+imgPath+"***"+price);
		DBConn db=new DBConn();
		db.insertDB(company, imgPath, price);
	}
}
