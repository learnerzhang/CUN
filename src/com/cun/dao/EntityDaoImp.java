package com.cun.dao;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import com.cun.model.Page;

public class EntityDaoImp implements EntityDao {

	@Override
	public void save(Object object) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		session.save(object);
		tr.commit();
	}

	@Override
	public void delete(Object object) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		session.delete(object);
		tr.commit();
	}

	@Override
	public void update(Object object) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		session.update(object);
		session.flush();
		tr.commit();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Object queryById(Class clazz, Integer id) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		return session.load(clazz, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> queryAllElement(Class clazz,String order) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		Criteria criteria = session.createCriteria(clazz);
		List<Object> list = criteria.addOrder(Order.desc(order)).list();
		if (order==null) {
			list = criteria.list();
		}else {
			list = criteria.addOrder(Order.desc(order)).list();
		}
		tr.commit();
		return list;
	}

	@Override
	public void deleteElement(Class clazz, Integer id) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		Query query = (Query) session.createQuery("delete " + clazz + " where id=:id");
		query.setParameter("id", id);
		query.executeUpdate();
		tr.commit();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> getElementByPage(Class clazz, Page page,String order) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		Criteria criteria = session.createCriteria(clazz);
		List<Object> list = null;
		if (order!=null) {
			list = criteria.addOrder(Order.desc(order)).setFirstResult(page.getBeginIndex()).setMaxResults(page.getPageSize()).list();
		}else {
			list = criteria.setFirstResult(page.getBeginIndex()).setMaxResults(page.getPageSize()).list();
		}
		tr.commit();
		return list;
	}

	@Override
	public Integer getTotalElementNum(Class clazz) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		Criteria criteria = session.createCriteria(clazz);
		Long count = (Long) criteria.setProjection(Projections.rowCount()).uniqueResult();
		tr.commit();
		return count.intValue();
	}

	@Override
	public Object queryElementByParmaterPairs(Class clazz, String[] keys, Object[] values) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		Criteria criteria = session.createCriteria(clazz);
		for (int i = 0; i < keys.length; i++) {
			criteria.add(Restrictions.eq(keys[i], values[i]));//添加约束
		}
		Object object = criteria.uniqueResult();
		tr.commit();
		return object;
	}

	@Override
	public Object queryElementBykey(Class clazz, String key, Object value) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		Criteria criteria = session.createCriteria(clazz);
		criteria.add(Restrictions.eq(key, value));//添加约束
		Object object = criteria.uniqueResult();
		tr.commit();
		return object;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> getElementByParmaterPage(Class clazz, Page page, String key, Object value,String order) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务		
		Criteria criteria = session.createCriteria(clazz);
		List<Object> list = null;
		if(order==null){
			list = criteria.add(Restrictions.eq(key, value)).setFirstResult(page.getBeginIndex()).setMaxResults(page.getPageSize()).list();
		}else {
			list = criteria.add(Restrictions.eq(key, value)).addOrder(Order.desc(order)).setFirstResult(page.getBeginIndex()).setMaxResults(page.getPageSize()).list();
		}
		
		tr.commit();
		return list;
	}
	
	@Override
	public Integer getElementNumByParmater(Class clazz,String key, Object value) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		Criteria criteria = session.createCriteria(clazz);
		Long count = (Long) criteria.add(Restrictions.eq(key, value)).setProjection(Projections.rowCount()).uniqueResult();
		tr.commit();
		return count.intValue(); 
	}

	@Override
	public Integer getElementNumByParmaterPairs(Class clazz,String[] keys, Object[] values) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		Criteria criteria = session.createCriteria(clazz);
		for (int i = 0; i < keys.length; i++) {
			criteria.add(Restrictions.eq(keys[i], values[i]));//添加约束
		}
		Long count = (Long) criteria.setProjection(Projections.rowCount()).uniqueResult();
		tr.commit();
		return count.intValue();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Object> getElementByParmaterPairsPage(Class clazz, Page page, String[] keys, Object[] values,String order) {
		// TODO Auto-generated method stub
		Session session = HibernateSessionFactory.getSession();// 获得session
		Transaction tr = session.beginTransaction();// 开启事务
		Criteria criteria = session.createCriteria(clazz);
		for (int i = 0; i < keys.length; i++) {
			criteria.add(Restrictions.eq(keys[i], values[i]));//添加约束
		}
		List<Object> list = null;
		if (order==null) {
			list = criteria.setFirstResult(page.getBeginIndex()).setMaxResults(page.getPageSize()).list();
		}else {
			list = criteria.addOrder(Order.desc(order)).setFirstResult(page.getBeginIndex()).setMaxResults(page.getPageSize()).list();
		}
		tr.commit();
		return list;
	}

}
