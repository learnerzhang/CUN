package com.cun.service;

import java.util.List;

import com.cun.dao.EntityDao;
import com.cun.dao.EntityDaoImp;
import com.cun.model.Page;
import com.cun.model.User;

public class UserService {

	public EntityDao entityDao = null;
	
	public UserService() {
		// TODO Auto-generated constructor stub
		entityDao = new EntityDaoImp();
	}
	
	public Integer verifyUser(User user){
		
		User u = (User) entityDao.queryElementByParmaterPairs(User.class, new String[]{"username","password"}, new String[]{user.getUsername(),user.getPassword()});
		if (u==null) {
			User uu = (User) entityDao.queryElementBykey(User.class, "username", user.getUsername());
			if (uu==null) {
				return 2;//不存在用户
			}else {
				return 3;//密码错误
			}
		}else {
			return 0;
		}
	}
	
	public void AddUser(User user){
		entityDao.save(user);
	}
	
	public void updateUser(User user){
		entityDao.update(user);
	}
	
	public void delUser(User user){
		entityDao.delete(user);
	}
	
	public User getUserById(String id)
	{
		return (User) entityDao.queryById(User.class, Integer.valueOf(id));
	}
	
	public User getUserInfo(User user)
	{
		User u = (User) entityDao.queryElementBykey(User.class, "username", user.getUsername());
		return u;
	}
	
	public List<Object> getAllUser(Page page,String type){
		return entityDao.getElementByParmaterPage(User.class, page, "type", type,"createtime");
	}
	
	public Integer getAllUserNum(String type){
		return entityDao.getElementNumByParmater(User.class, "type",type);
	}
}
