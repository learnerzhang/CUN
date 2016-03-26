package com.cun.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.cun.model.Page;
import com.cun.service.CorpusService;
import com.cun.util.PageUtil;

/**
 * Servlet implementation class TendencyServlet
 */
public class TendencyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private transient final Log log = LogFactory.getLog(TendencyServlet.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TendencyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		String ptype = request.getParameter("type");
		CorpusService service = new CorpusService();
		log.info("op: " + ptype);
		if (ptype.equals("list")) {
			String flag_tendency = request.getParameter("flag_tendency");
			String p = request.getParameter("page");
			Integer totalCount = service.getAllTendencyCorpusNum(flag_tendency);
			Page page = PageUtil.createPage(10, totalCount, Integer.valueOf(p));
			List<Object> corpus = service.getAllTendencyCorpus(page, flag_tendency);
			request.setAttribute("corpus",corpus);
			request.setAttribute("page", page);
			request.getRequestDispatcher("WEB-INF/sys/corpus_tendency.jsp").forward(request, response);
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
