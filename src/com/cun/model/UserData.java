package com.cun.model;

public class UserData {

	private String username;
	private String name;
	private Integer totalNum;
	private Integer neuNum;
	private Integer sentiNum;
	
	
	
	public UserData(String username, String name, Integer totalNum, Integer neuNum, Integer sentiNum) {
		super();
		this.username = username;
		this.name = name;
		this.totalNum = totalNum;
		this.neuNum = neuNum;
		this.sentiNum = sentiNum;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}
	public Integer getNeuNum() {
		return neuNum;
	}
	public void setNeuNum(Integer neuNum) {
		this.neuNum = neuNum;
	}
	public Integer getSentiNum() {
		return sentiNum;
	}
	public void setSentiNum(Integer sentiNum) {
		this.sentiNum = sentiNum;
	}
	
}
