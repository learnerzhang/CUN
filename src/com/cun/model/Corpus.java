package com.cun.model;

import java.io.Serializable;
import java.sql.Timestamp;
@SuppressWarnings("serial")
public class Corpus implements Serializable{

	private Integer id;
	private String username;
	private Timestamp timestamp;
	private String context;
	private String addition;
	private String tagging;
	private String negative;
	private String degree;
	private String type;
	private String tendency;
	private String flag_tendency;//标记是否处理过
	private String feature;//特征集合[句子特征;词汇特征;...]
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Timestamp getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getAddition() {
		return addition;
	}
	public void setAddition(String addition) {
		this.addition = addition;
	}
	public String getTagging() {
		return tagging;
	}
	public void setTagging(String tagging) {
		this.tagging = tagging;
	}
	public String getTendency() {
		return tendency;
	}
	public void setTendency(String tendency) {
		this.tendency = tendency;
	}
	public String getFlag_tendency() {
		return flag_tendency;
	}
	public void setFlag_tendency(String flag_tendency) {
		this.flag_tendency = flag_tendency;
	}
	public String getFeature() {
		return feature;
	}
	public void setFeature(String feature) {
		this.feature = feature;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getNegative() {
		return negative;
	}
	public void setNegative(String negative) {
		this.negative = negative;
	}
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	@Override
	public String toString() {
		return "Corpus [id=" + id + ", username=" + username + ", timestamp=" + timestamp + ", context=" + context
				+ ", addition=" + addition + ", tagging=" + tagging + ", negative=" + negative + ", degree=" + degree
				+ ", type=" + type + ", tendency=" + tendency + ", flag_tendency=" + flag_tendency + ", feature="
				+ feature + "]";
	}
}
