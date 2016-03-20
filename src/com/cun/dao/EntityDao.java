package com.cun.dao;

import java.util.List;

import com.cun.model.Page;

public interface EntityDao {

	public void save(Object object);
	
	public void delete(Object object);
	
	public void update(Object object);
	
	public Object queryById(Class clazz,Integer id);
	
	public Object queryElementBykey(Class clazz,String key, Object value);
	
	public Object queryElementByParmaterPairs(Class clazz,String[] keys, Object[] values);
	
	public List<Object> queryAllElement(Class clazz);
	
	public void deleteElement(Class clazz,Integer id);
	
	public List<Object> getElementByPage(Class clazz,Page page);// 查询数据信息的方法
	
	public Integer getTotalElementNum(Class clazz);//求最大页数的方法
	
}
