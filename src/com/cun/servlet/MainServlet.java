package com.cun.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.cun.service.CorpusService;

/**
 * Servlet implementation class MainServlet
 */
public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static transient Log log = LogFactory.getLog(MainServlet.class);   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MainServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		String username = request.getParameter("username");
		String type = request.getParameter("type");
		CorpusService service = new CorpusService();
		int[] tendency = new int[2];
		int[][] weekdata = new int[7][2];
		if ("2".equals(type)) {
			tendency[0] = service.getAllTendencyUserCorpusNum(username, "1", "o;");//中性
			tendency[1] = service.getAllTendencyUserCorpusNum(username, "1")-tendency[0];//情感的
			
			log.debug("total: 中性句=="+tendency[0]+" 情感句="+tendency[1]);
			/*
			 * 2016-03-29 23:28:20
			 * */
			Date date = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			for (int i = 0; i < 7; i++) {
				Date d = new Date(System.currentTimeMillis()-i * 24 * 3600 * 1000);
				String timestamp = format.format(d);
				weekdata[i][0] = service.getAllTendencyUserCorpusNum(username, "1", "o;", "timestamp", timestamp);//中性
				weekdata[i][1] = service.getAllTendencyByUserCorpusNum(username, "1","timestamp", timestamp)-weekdata[i][0];//情感倾向
				log.debug(timestamp+"/"+weekdata[i][0]+"/"+weekdata[i][1]);
			}
		}else {
			tendency[0] = service.getAllTendencyCorpusNum("1", "o;");//中性
			tendency[1] = service.getAllTendencyCorpusNum("1")-tendency[0];
			log.debug("total: 中性句=="+tendency[0]+" 情感句="+tendency[1]);
			/*
			 * 2016-03-29 23:28:20
			 * */

			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			for (int i = 0; i < 7; i++) {
				Date d = new Date(System.currentTimeMillis()-i * 24 * 3600 * 1000);
				String timestamp = format.format(d);
				weekdata[i][0] = service.getAllTendencyUserCorpusNum("1", "o;", "timestamp", timestamp);
				weekdata[i][1] = service.getAllTendencyCorpusNum("1","timestamp", timestamp)-weekdata[i][0];
				log.debug(timestamp+"/"+weekdata[i][0]+"/"+weekdata[i][1]);
			}
		}
		request.setAttribute("tendency", tendency);
		request.setAttribute("weekdata", weekdata);
		request.getRequestDispatcher("WEB-INF/sys/main.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
