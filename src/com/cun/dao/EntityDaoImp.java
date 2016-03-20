package com.cun.dao;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.cun.model.Page;

public class EntityDaoImp implements EntityDao {

	Session session = HibernateSessionFactory.getSession();// 获得session

	@Override
	public void save(Object object) {
		// TODO Auto-generated method stub
		Transaction tr = session.beginTransaction();// 开启事务
		session.save(object);
		tr.commit();
	}

	@Override
	public void delete(Object object) {
		// TODO Auto-generated method stub
		Transaction tr = session.beginTransaction();// 开启事务
		session.delete(object);
		tr.commit();
	}

	@Override
	public void update(Object object) {
		// TODO Auto-generated method stub
		Transaction tr = session.beginTransaction();// 开启事务
		session.update(object);
		session.flush();
		tr.commit();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Object queryById(Class clazz, Integer id) {
		// TODO Auto-generated method stub
		Transaction tr = session.beginTransaction();// 开启事务
		return session.load(clazz, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> queryAllElement(Class clazz) {
		// TODO Auto-generated method stub
		Transaction tr = session.beginTransaction();// 开启事务
		List<Object> list = null;
		list = session.createQuery("from " + clazz).list();
		tr.commit();
		return list;
	}

	@Override
	public void deleteElement(Class clazz, Integer id) {
		// TODO Auto-generated method stub
		Transaction tr = session.beginTransaction();// 开启事务
		Query query = (Query) session.createQuery("delete " + clazz + " where id=:id");
		query.setParameter("id", id);
		query.executeUpdate();
		tr.commit();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> getElementByPage(Class clazz, Page page) {
		// TODO Auto-generated method stub
		Transaction tr = session.beginTransaction();// 开启事务
		List<Object> list = null;
		list = session.createQuery("from " + clazz).setFirstResult(page.getBeginIndex()).setMaxResults(page.getPageSize()).list();
		tr.commit();
		return list;
	}

	@Override
	public Integer getTotalElementNum(Class clazz) {
		// TODO Auto-generated method stub
		Transaction tr = session.beginTransaction();// 开启事务
		return (Integer) session.createQuery("select count (*) from " + clazz).uniqueResult();
	}

	@Override
	public Object queryElementByParmaterPairs(Class clazz, String[] keys, Object[] values) {
		// TODO Auto-generated method stub
		Criteria criteria = session.createCriteria(clazz);
		for (int i = 0; i < keys.length; i++) {
			criteria.add(Restrictions.eq(keys[i], values[i]));//添加约束
		}
		return criteria.uniqueResult();
	}

	@Override
	public Object queryElementBykey(Class clazz, String key, Object value) {
		// TODO Auto-generated method stub
		Criteria criteria = session.createCriteria(clazz);
		criteria.add(Restrictions.eq(key, value));//添加约束
		return criteria.uniqueResult();
	}

}
