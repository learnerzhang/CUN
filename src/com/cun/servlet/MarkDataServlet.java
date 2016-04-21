package com.cun.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cun.model.Corpus;
import com.cun.model.Page;
import com.cun.model.User;
import com.cun.model.UserData;
import com.cun.service.CorpusService;
import com.cun.service.UserService;
import com.cun.util.PageUtil;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class MarkDataServlet
 */
public class MarkDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MarkDataServlet() {
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
		CorpusService service = new CorpusService();
		UserService userService = new UserService();
		
		if (type.equals("info")) {
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("user");
			if (user==null) {
				request.getRequestDispatcher("WEB-INF/sys/login.jsp").forward(request, response);
			}
			String username = user.getUsername();
			String p = request.getParameter("page");
			Integer totalCount = service.getAllTendencyUserCorpusNum(username, "1");
			Page page = PageUtil.createPage(10, totalCount, Integer.valueOf(p));
			List<Object> corpus = service.getAllTendencyUserCorpus(page, username, "1");
			
			request.setAttribute("page", page);
			request.setAttribute("corpus", corpus);
			request.getRequestDispatcher("WEB-INF/sys/user_data.jsp").forward(request, response);
			return;
		}else if (type.equals("load")) {
			String id = request.getParameter("id");
			String page = request.getParameter("page");
			Corpus corpus = service.getCorpusById(id);
			request.setAttribute("page", page);
			request.setAttribute("corpus", corpus);
			request.getRequestDispatcher("WEB-INF/sys/corpus_update.jsp").forward(request, response);
		}else if (type.equals("reset")) {
			String id = request.getParameter("id");
			Corpus corpus = service.getCorpusById(id);
			System.out.println(corpus);
			response.setContentType("text/plain;charset=utf-8");
			PrintWriter out = response.getWriter();
			JSONObject object = new JSONObject();
			corpus.setFlag_tendency("0");
			try {
				service.updateCorpus(corpus);
				object.put("code", "0");
			} catch (Exception e) {
				// TODO: handle exception
				object.put("code", "1");
			}
			out.write(object.toString());
			return;
		}else if (type.equals("other")) {
			List<UserData> datas = new ArrayList<>();
			List<Object> users = userService.getAllUser(PageUtil.createPage(10, userService.getAllUserNum("2"), 1), "2");
			
			for (Object object : users) {
				
				User user = (User) object;
				String username = user.getUsername();
				String name = user.getName();
				Integer totalNum = service.getAllTendencyUserCorpusNum(username, "1");
				Integer negNum = service.getAllTendencyUserCorpusNum(username, "1", "0");
				Integer neuNum = service.getAllTendencyUserCorpusNum(username, "1", "1");
				Integer posNum = service.getAllTendencyUserCorpusNum(username, "1", "2");
				UserData userData = new UserData(username, name, totalNum, posNum, negNum, neuNum);
				datas.add(userData);
			}
			
			request.setAttribute("datas", datas);
			request.getRequestDispatcher("WEB-INF/sys/comparedata.jsp").forward(request, response);
			return;
		}else if (type.equals("all")) {
			List<UserData> datas = new ArrayList<>();
			List<Object> users = userService.getAllUser(PageUtil.createPage(10, userService.getAllUserNum("2"), 1), "2");
			
			for (Object object : users) {
				
				User user = (User) object;
				String username = user.getUsername();
				String name = user.getName();
				Integer totalNum = service.getAllTendencyUserCorpusNum(username, "1");
				Integer negNum = service.getAllTendencyUserCorpusNum(username, "1", "0");
				Integer neuNum = service.getAllTendencyUserCorpusNum(username, "1", "1");
				Integer posNum = service.getAllTendencyUserCorpusNum(username, "1", "2");
				UserData userData = new UserData(username, name, totalNum, posNum, negNum, neuNum);
				datas.add(userData);
			}
			
			request.setAttribute("datas", datas);
			request.getRequestDispatcher("WEB-INF/sys/markdata.jsp").forward(request, response);
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
