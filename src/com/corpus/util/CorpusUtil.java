package com.corpus.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.cun.dao.EntityDao;
import com.cun.dao.EntityDaoImp;
import com.cun.model.Corpus;

public class CorpusUtil {

	private transient static Log log = LogFactory.getLog(CorpusUtil.class);
	public static boolean isZangSign(char c) {
		return c >= 3840 && c <= 4095 || c == ' ';
	}

	// 对藏文微博进行处理!!! 只要正文
	public static String getZangWen(String context) {

		StringBuffer sb = new StringBuffer();
		context = context.split(":")[1];
		for (int i = 0; i < context.length(); i++) {
			if (!isZangSign(context.charAt(i))) {
				continue;
			} else {
				sb.append(context.charAt(i));
			}
		}
		return sb.toString().trim();
	}

	public static String getZangContext(String pathname) {

		File file = new File(pathname);
		return getZangContext(file);
	}

	public static String getZangContext(File file) {

		try {
			BufferedReader br = new BufferedReader(new FileReader(file));
			String line = "";
			while ((line = br.readLine()) != null) {
				if (line.startsWith("#内容:")) {
					return getZangWen(line);
				}
			}

		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public static void main(String[] args) throws FileNotFoundException {
		//EntityDao dao = new EntityDaoImp();
		File root = new File("D://Weibo_zangyu_special");
		File[] files = root.listFiles();
		FileOutputStream fos = new FileOutputStream("D://corpus.txt", true);
		for (File file : files) {
			String context = getZangContext(file);
			if (context==""||context==null) {
				continue;
			}
			try {
				fos.write((context+"\r\n").getBytes());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//Corpus corpus = new Corpus();
			//corpus.setContext(context);
			//corpus.setFlag_feature("0");
			//corpus.setFlag_tendency("0");
			//corpus.setUsername("admin");
			//dao.save(corpus);
		}
		try {
			if (fos!=null) {
				fos.close();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
