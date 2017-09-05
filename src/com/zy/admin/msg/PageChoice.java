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
		//��ȡĿ��ҳ��
		for(int i=0;i<param.length;i++){
			//��ȡ���͵���Ϣ
			targetPath=proPath+"/"+param[i];
			System.out.println("targetPath***"+targetPath);
			//����
			Browser.withPage(targetPath, new Runnable() {
				//new Runnable��һ�������ڲ��� �������Ҫ����final����
				//�����ڲ�������ⲿ���еĶ��� 
				public void run() {
					// TODO Auto-generated method stub
					//����Ŀ��ҳ��js�����ĺ����� msg��Ŀ��ҳ�����͵���Ϣ
					ScriptSessions.addFunctionCall("usershow", msg);
				}
			});
		}
		
	}
	
	//�Զ����� �̵߳��Զ��嶨ʱ����
	public void sendMsg(String[] param){
		System.out.println("sendMsg() is start...");
		//������ʱ��
		Timer timer=new Timer();
		timer.schedule(new UserTask(param), 1000, 20*1000);
	}
	
	public void loadJspFiles(File file){
		File[] files=file.listFiles();
		
		for(File f:files){
			if(f.isFile()){
				//������ļ��Ļ��ж��ǲ�����.jsp,.html��β,
				if(f.getName().endsWith(".jsp")||f.getName().endsWith(".html")){
					pathLists.add(f.getAbsolutePath());
				}
			}else{
				//�ļ��Ǹ�Ŀ¼����Ҫȥ�ݹ�
				loadJspFiles(f);
			}
		}
	}
	//�õ��˵ݹ���� ������ļ����ǲ�����jsp/html��β�� 
	//�����Ŀ¼����ȥ�ݹ���÷�������
	public List<String> getPage(){
		//���Ȼ��tomcat����·��
		ServerContext sc=ServerContextFactory.get();
		ServletContext servletContext=sc.getServletContext();
		String tomcatPath=servletContext.getRealPath("");
		System.out.println("tomcatPath***"+tomcatPath);
		//��ȡ��ǰ��Ŀ����
		String proPath=tomcatPath.substring(tomcatPath.lastIndexOf("\\")+1);
		System.out.println("proPath***"+proPath);
		//ȡ��tomcat·���µ����е��ļ����ļ���
		File file=new File(tomcatPath);
		pathLists=new ArrayList<String>();
		pathLists.add(proPath);
		loadJspFiles(file);
		return pathLists;
	}
}
