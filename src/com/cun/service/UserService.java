package com.cun.service;

import com.cun.dao.EntityDao;
import com.cun.dao.EntityDaoImp;
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
	
	public User getUserInfo(User user)
	{
		User u = (User) entityDao.queryElementBykey(User.class, "username", user.getUsername());
		return u;
	}
}
