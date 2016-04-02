package com.cun.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.cun.model.Corpus;
import com.cun.model.Page;
import com.cun.service.CorpusService;
import com.cun.util.IOUtil;
import com.cun.util.PageUtil;

import net.sf.json.JSONObject;

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
			
			request.setAttribute("flag_tendency",flag_tendency);
			request.setAttribute("corpus",corpus);
			request.setAttribute("page", page);
			request.getRequestDispatcher("WEB-INF/sys/corpus_tendency.jsp").forward(request, response);
		}else if (ptype.equals("add")) {
			
			response.setContentType("text/plain;charset=utf-8");
			PrintWriter out = response.getWriter();
			String uString = IOUtil.readJSONString(request);
			JSONObject jsonObject = JSONObject.fromObject(uString);
			
			JSONObject object = new JSONObject();
			
			String username = (String) jsonObject.get("username");
			String context = (String) jsonObject.get("context");
			String tendency = (String) jsonObject.get("tendency");
			Corpus corpus = new Corpus();
			
			corpus.setContext(context);
			corpus.setUsername(username);
			corpus.setFlag_feature("0");
			corpus.setFlag_tendency("1");
			corpus.setTendency(tendency);
			corpus.setTimestamp(new Timestamp(System.currentTimeMillis()));
			
			try {
				service.AddCorpus(corpus);
				object.put("code", "0");
			} catch (Exception e) {
				// TODO: handle exception
				object.put("code", "1");
			}
			out.write(object.toString());
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
