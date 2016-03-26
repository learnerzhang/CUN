package com.cun.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.List;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cun.model.Corpus;
import com.cun.model.Page;
import com.cun.service.CorpusService;
import com.cun.util.CorpusPool;
import com.cun.util.IOUtil;
import com.cun.util.PageUtil;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class MarkTendencyServlet
 */
public class MarkTendencyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MarkTendencyServlet() {
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
		if(type.equals("update")) {
			
			response.setContentType("text/plain;charset=utf-8");
			PrintWriter out = response.getWriter();
			JSONObject object = new JSONObject();
			
			String uString = IOUtil.readJSONString(request);
			JSONObject jsonObject = JSONObject.fromObject(uString);
			String id = jsonObject.getString("id");
			String tendency = jsonObject.getString("type");//倾向类型
			String username = jsonObject.getString("username");
			Corpus corpus = service.getCorpusById(id);
			
			corpus.setFlag_tendency("1");
			corpus.setUsername(username);
			corpus.setTendency(tendency);
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			corpus.setTimestamp(timestamp);
			try {
				service.updateCorpus(corpus);
				object.put("code", "0");
			} catch (Exception e) {
				// TODO: handle exception
				object.put("code", "1");
			}
			out.write(object.toString());
			return;
		}else if (type.equals("load")) {
			List<Corpus> pool = CorpusPool.pool;
			if (pool.size()==0) {//随机添加数据...
				Integer count = service.getAllTendencyCorpusNum("0");//未倾向标记的句子
				Integer totalPage =  (int) Math.ceil(1.0*count/10);
				Random random = new Random(System.currentTimeMillis());
				int	currentPage =random.nextInt(totalPage)+1;
				System.out.println("count:"+count+" ;currentPage :"+currentPage+" ;totalPage :"+totalPage);
				Page page = PageUtil.createPage(10, count, currentPage);
				List<Object> corpus = service.getAllTendencyCorpus(page, "0");
				for (Object object : corpus) {
					Corpus c = (Corpus) object;
					pool.add(c);
				}
			}
			Corpus corpus = pool.remove(0);
			request.setAttribute("corpus", corpus);
			request.getRequestDispatcher("WEB-INF/sys/mark_tendency.jsp").forward(request, response);
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
