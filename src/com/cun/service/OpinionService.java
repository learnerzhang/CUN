package com.cun.service;

import java.util.List;

import com.cun.dao.EntityDao;
import com.cun.dao.EntityDaoImp;
import com.cun.model.Opinion;
import com.cun.model.Page;

public class OpinionService {

	public EntityDao entityDao = null;
	public OpinionService() {
		// TODO Auto-generated constructor stub
		entityDao = new EntityDaoImp();
	}
	
	public void AddOpinion(Opinion opinion){
		entityDao.save(opinion);
	}
	
	public void updateOpinion(Opinion opinion){
		entityDao.update(opinion);
	}
	
	public void delOpinion(Opinion opinion){
		entityDao.delete(opinion);
	}
	
	public List<Object> getAllOpinion(Page page){
		return entityDao.getElementByPage(Opinion.class, page,"timestamp");
	}
	
	public Integer getAllOpinionNum(){
		return entityDao.getTotalElementNum(Opinion.class);
	}
}
