package com.cun.nlp;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class NetUtil {

	static HttpClient httpClient = new DefaultHttpClient();

	public static String getPageToken() {

		HttpGet httpGet = new HttpGet("http://103.247.176.245:8081/tool/syllabletag/");
		try {
			HttpResponse response = httpClient.execute(httpGet);
			String doc = EntityUtils.toString(response.getEntity());
			Document document = Jsoup.parse(doc);
			String token = document.select("input[name=csrfmiddlewaretoken]").val();
			// System.out.println(token);

			return token;

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public static void getResource() {
		HttpClient httpClient = new DefaultHttpClient();
		HttpPost postRequest = new HttpPost("http://103.247.176.245:8081/tool/syllabletag/");
		MultipartEntity reqEntity = new MultipartEntity(HttpMultipartMode.BROWSER_COMPATIBLE);
		try {
			reqEntity.addPart("csrfmiddlewaretoken", new StringBody(getPageToken()));
			reqEntity.addPart("input_text", new StringBody("hahhahhahahahah"));
			reqEntity.addPart("output_text", new StringBody(""));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		postRequest.setEntity(reqEntity);
		HttpResponse response;
		try {
			response = httpClient.execute(postRequest);
			BufferedReader reader = new BufferedReader(new InputStreamReader(response.getEntity().getContent(), "UTF-8"));
			String sResponse;
			StringBuilder s = new StringBuilder();
			while ((sResponse = reader.readLine()) != null) {
				s = s.append(sResponse);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static void main(String[] args) {
		NetUtil.getResource();
	}
}
