package com.cun.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ConnectionFactory {

	private String driver;
	private String url;
	private String username;
	private String password;
	private String db;
	public final static String MYSQL_DB = "mysql";
	private static ConnectionFactory connFactory = null;
	private transient Log log = LogFactory.getLog(ConnectionFactory.class);
	
	public String getDriver() {
		return driver;
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
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

	public String getDb() {
		return db;
	}

	public void setDb(String db) {
		this.db = db;
	}

	public static ConnectionFactory getConnFactory() {
		return connFactory;
	}

	public static void setConnFactory(ConnectionFactory connFactory) {
		ConnectionFactory.connFactory = connFactory;
	}

	public static String getMysqlDb() {
		return MYSQL_DB;
	}

	public ConnectionFactory(String db) {
		// TODO Auto-generated constructor stub
		try {
			initDBParams(db);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void initDBParams(String db) throws IOException {
		// TODO Auto-generated method stub
		Properties properties = new Properties();
		InputStream in = new FileInputStream(new File("src/db.properties"));
		properties.load(in);
		getParams(properties, db);
	}

	private void getParams(Properties properties, String db) {
		// TODO Auto-generated method stub
		driver = properties.getProperty(db + ".driver").trim();
		url = properties.getProperty(db + ".url").trim();
		username = properties.getProperty(db + ".username").trim();
		password = properties.getProperty(db + ".password").trim();
		
		log.info("read from the conf:");
		log.info("driver:"+driver);
		log.info("url:"+url);
		log.info("username:"+username);
		log.info("password:"+password);
	}

	public static synchronized ConnectionFactory getConnFactoryInstance(String db) {
		if (connFactory == null) {
			connFactory = new ConnectionFactory(db);
		}
		return connFactory;
	}

	public Connection getConn() {
		Connection conn = null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, username, password);
			// 设置不自动提交
			conn.setAutoCommit(false);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

	public static void close(Connection conn) {
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/*public static void main(String[] args) {
		ConnectionFactory factory = ConnectionFactory.getConnFactoryInstance(ConnectionFactory.MYSQL_DB);
		Connection conn = factory.getConn();
	}*/
}
