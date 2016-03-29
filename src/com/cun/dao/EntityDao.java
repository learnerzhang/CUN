package com.cun.dao;

import java.util.List;

import com.cun.model.Page;

public interface EntityDao {

	public void save(Object object);
	
	public void delete(Object object);
	
	public void update(Object object);
	
	public Object queryById(Class clazz,Integer id);
	
	public Object queryElementBykey(Class clazz,String key, Object value);
	
	public Integer getElementNumByParmater(Class clazz,String key, Object value);
	
	public List<Object> getElementByParmaterPage(Class clazz,Page page,String key, Object value,String order);// 查询数据信息的方法
	
	public Object queryElementByParmaterPairs(Class clazz,String[] keys, Object[] values);
	
	public Integer getElementNumByParmaterPairs(Class clazz,String[] keys, Object[] values); 
	
	public List<Object> getElementByParmaterPairsPage(Class clazz,Page page,String[] keys, Object[] values,String order);// 查询数据信息的方法
	
	public List<Object> queryAllElement(Class clazz,String order);
	
	public void deleteElement(Class clazz,Integer id);
	
	public List<Object> getElementByPage(Class clazz,Page page,String order);// 查询数据信息的方法
	
	public Integer getTotalElementNum(Class clazz);//求最大页数的方法
	
}
