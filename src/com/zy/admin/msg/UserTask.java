package com.zy.admin.msg;

import java.util.TimerTask;

import org.directwebremoting.Browser;
import org.directwebremoting.ScriptSessions;
import org.directwebremoting.ServerContextFactory;

import com.zy.operate.db.DBConn;

public class UserTask extends TimerTask{
	String page;
	public UserTask(String[] param){
		for(int i=0;i<param.length;i++){
			page=param[i];
		}
	}
	@Override
	public void run() {
		// TODO Auto-generated method stub
		System.out.println("thread***"+Thread.currentThread().getName());
		String proPath=ServerContextFactory.get().getContextPath();
		String targetPath=proPath+"/"+page;
		DBConn db=new DBConn();
		//推送的消息
		final String msg=db.getBiddingInfo();
		System.out.println("msg***"+msg);
		System.out.println("page***"+page);
		
		Browser.withPage(targetPath, new Runnable() {
			
			public void run() {
				// TODO Auto-generated method stub
				ScriptSessions.addFunctionCall("usershow", msg);
			}
		});
	}

}
