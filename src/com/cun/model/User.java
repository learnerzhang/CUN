package com.cun.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class User implements Serializable {

	private static final long serialVersionUID = 1L;
	private Integer id;
	private String username;
	private String password;
	private String sex;
	private String email;
	private String phone;
	private String type;
	private String status;
	private Timestamp createtime;

	public User() {
	}

	public User(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public User(String username, String password, String type) {
		this(username, password);
		this.type = type;
	}

	public User(String username, String password, String type, String status) {
		this(username, password, type);
		this.status = status;
	}

	public User(String username, String password, String sex, String email, String phone, String type, String status) {
		this(username, password, type, status);
		this.sex = sex;
		this.email = email;
		this.phone = phone;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Timestamp createtime) {
		this.createtime = createtime;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "User[username=" + username + ", type=" + type + ", status=" + status + "]";
	}
}
