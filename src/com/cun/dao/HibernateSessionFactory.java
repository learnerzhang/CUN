package com.cun.dao;

import org.hibernate.*;
import org.hibernate.cfg.*;

public class HibernateSessionFactory {
	private static Configuration cf = null;
	private static SessionFactory sf = null;

	static {
		try {
			cf = new Configuration().configure();
			sf = cf.buildSessionFactory();// 创建session
		} catch (Exception e) {
			// TODO: handle exception
			throw new RuntimeException("Create SessionFactory Fail.", e);
		}
	}

	public static Session getSession() {// 获得session的方法
		Session session = null;
		try {
			if (session == null || session.isOpen() == false)
				session = null;
			session = sf.getCurrentSession();
		} catch (HibernateException e) {
			throw new RuntimeException("Create Session Fail", e);
		}
		return session;
	}

	public static void closed(Session session) {// 关闭session的方法
		try {
			if (session != null)
				session.close();
		} catch (HibernateException e) {
			throw new RuntimeException("Close Session Fail.", e);
		}
	}
}
