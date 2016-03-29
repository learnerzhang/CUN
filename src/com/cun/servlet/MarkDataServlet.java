package com.cun.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cun.model.Corpus;
import com.cun.model.Page;
import com.cun.model.User;
import com.cun.service.CorpusService;
import com.cun.util.PageUtil;

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
		}else if (type.equals("other")) {
			response.getWriter().append("Served at: ").append(request.getContextPath()+" other");
		}else if (type.equals("all")) {
			response.getWriter().append("Served at: ").append(request.getContextPath()+" all");
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
