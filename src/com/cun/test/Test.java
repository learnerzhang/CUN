package com.cun.test;


import com.cun.dao.EntityDao;
import com.cun.dao.EntityDaoImp;
import com.cun.model.User;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		/* SessionFactory sf = new Configuration().configure().buildSessionFactory();
		 Session session = sf.openSession();
		 
		 Transaction tx = session.beginTransaction();
		 User user = new User("admin","admin","0","yes");
		 session.save(user);
		 tx.commit();
		 session.close();*/
		
		EntityDao dao = new EntityDaoImp();
		
		User user =(User) dao.queryElementByParmaterPairs(User.class, new String[]{"username","password"}, new String[]{"admin","admin"});
		System.out.println(user);
	}

}
