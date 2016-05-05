package com.cun.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cun.model.Opinion;
import com.cun.model.Page;
import com.cun.service.OpinionService;
import com.cun.util.IOUtil;
import com.cun.util.PageUtil;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class OpinionServlet
 */
public class OpinionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OpinionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		
		String type = request.getParameter("type");
		OpinionService service = new OpinionService();
		if (type.equals("add")) {
			response.setContentType("text/plain;charset=utf-8");
			JSONObject object = new JSONObject();
			
			PrintWriter out = response.getWriter();
			String uString = IOUtil.readJSONString(request);
			JSONObject jsonObject = JSONObject.fromObject(uString);
			
			String context = (String) jsonObject.get("context");
			String username = (String) jsonObject.get("username");
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			Opinion opinion = new Opinion();
			opinion.setTimestamp(timestamp);
			opinion.setContext(context);
			opinion.setUsername(username);
			System.out.println(opinion);
			try {
				service.AddOpinion(opinion);
				object.put("code", "0");
			} catch (Exception e) {
				// TODO: handle exception
				object.put("code", "1");
			}
			out.write(object.toString());
		}else if (type.equals("list")) {
			String p = request.getParameter("page");
			Integer total = service.getAllOpinionNum();
			Page page = PageUtil.createPage(10, total, Integer.valueOf(p));
			
			List<Object> opinions = service.getAllOpinion(page);
			
			request.setAttribute("page", page);
			request.setAttribute("opinions", opinions);
			request.getRequestDispatcher("WEB-INF/sys/opinion.jsp").forward(request, response);
			return;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
