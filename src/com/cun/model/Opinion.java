package com.cun.model;

import java.sql.Timestamp;

public class Opinion {

	private Integer id;
	private String username;
	private String context;
	private Timestamp timestamp;
	
	public Opinion() {
		// TODO Auto-generated constructor stub
	}

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

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public Timestamp getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

	@Override
	public String toString() {
		return "Opinion [id=" + id + ", username=" + username + ", context=" + context + ", timestamp=" + timestamp
				+ "]";
	}
}
