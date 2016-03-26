package com.cun.service;

import java.util.List;

import com.cun.dao.EntityDao;
import com.cun.dao.EntityDaoImp;
import com.cun.model.Corpus;
import com.cun.model.Page;
import com.cun.model.User;

public class CorpusService {

	public EntityDao entityDao = null;
	public CorpusService() {
		// TODO Auto-generated constructor stub
		entityDao = new EntityDaoImp();
	}
	
	public void AddCorpus(Corpus corpus){
		entityDao.save(corpus);
	}
	
	public void updateCorpus(Corpus corpus){
		entityDao.update(corpus);
	}
	
	public void delCorpus(Corpus corpus){
		entityDao.delete(corpus);
	}
	
	public Corpus getCorpusById(String id)
	{
		return (Corpus) entityDao.queryById(Corpus.class, Integer.valueOf(id));
	}
	
	public List<Object> getAllTendencyCorpus(Page page,String flag_tendency){
		return entityDao.getElementByParmaterPage(Corpus.class, page, "flag_tendency", flag_tendency);
	}
	public Integer getAllTendencyCorpusNum(String flag_tendency){
		return entityDao.getElementNumByParmater(Corpus.class, "flag_tendency",flag_tendency);
	}
	
	public List<Object> getAllFeatureCorpus(Page page,String flag_feature){
		return entityDao.getElementByParmaterPage(Corpus.class, page, "flag_feature", flag_feature);
	}
	public Integer getAllFeatureCorpusNum(String flag_feature){
		return entityDao.getElementNumByParmater(Corpus.class, "flag_feature",flag_feature);
	}
	
}
