package com.zy.admin.msg;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;

import javax.servlet.ServletContext;

import org.directwebremoting.Browser;
import org.directwebremoting.ScriptSessions;
import org.directwebremoting.ServerContext;
import org.directwebremoting.ServerContextFactory;

public class PageChoice {
	private List<String> pathLists;
	public void sendMsg(String[] param,final String msg){
		System.out.println("SendMsg sendMsg is start...");
		String proPath=ServerContextFactory.get().getContextPath();
		String targetPath;
		//获取目标页面
		for(int i=0;i<param.length;i++){
			//获取推送的消息
			targetPath=proPath+"/"+param[i];
			System.out.println("targetPath***"+targetPath);
			//推送
			Browser.withPage(targetPath, new Runnable() {
				//new Runnable是一个匿名内部类 这个对象要求是final类型
				//匿名内部类调用外部类中的对象 
				public void run() {
					// TODO Auto-generated method stub
					//呼叫目标页面js函数的函数名 msg向目标页面推送的消息
					ScriptSessions.addFunctionCall("usershow", msg);
				}
			});
		}
		
	}
	
	//自动推送 线程的自定义定时任务
	public void sendMsg(String[] param){
		System.out.println("sendMsg() is start...");
		//创建定时器
		Timer timer=new Timer();
		timer.schedule(new UserTask(param), 1000, 20*1000);
	}
	
	public void loadJspFiles(File file){
		File[] files=file.listFiles();
		
		for(File f:files){
			if(f.isFile()){
				//如果是文件的话判读是不是以.jsp,.html结尾,
				if(f.getName().endsWith(".jsp")||f.getName().endsWith(".html")){
					pathLists.add(f.getAbsolutePath());
				}
			}else{
				//文件是个目录，则要去递归
				loadJspFiles(f);
			}
		}
	}
	//用到了递归调用 如果是文件看是不是以jsp/html结尾的 
	//如果是目录，则去递归调用方法本身
	public List<String> getPage(){
		//首先获得tomcat所在路径
		ServerContext sc=ServerContextFactory.get();
		ServletContext servletContext=sc.getServletContext();
		String tomcatPath=servletContext.getRealPath("");
		System.out.println("tomcatPath***"+tomcatPath);
		//截取当前项目名称
		String proPath=tomcatPath.substring(tomcatPath.lastIndexOf("\\")+1);
		System.out.println("proPath***"+proPath);
		//取得tomcat路径下的所有的文件和文件夹
		File file=new File(tomcatPath);
		pathLists=new ArrayList<String>();
		pathLists.add(proPath);
		loadJspFiles(file);
		return pathLists;
	}
}
