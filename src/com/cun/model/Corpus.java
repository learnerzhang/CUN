package com.cun.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Corpus implements Serializable{

	private Integer id;
	private String context;
	private String addition;
	private String tagging;
	private String label;
	private String tendency;//0->消极 1->中性 2->消极
	private String flag_tendency;//标记是否处理过
	private String flag_feature;//标记是否处理过
	private String feature;//特征集合[句子特征;词汇特征;...]
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
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
	public String getFlag_feature() {
		return flag_feature;
	}
	public void setFlag_feature(String flag_feature) {
		this.flag_feature = flag_feature;
	}
	public String getFeature() {
		return feature;
	}
	public void setFeature(String feature) {
		this.feature = feature;
	}
}
