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

import com.cun.model.Page;
import com.cun.model.User;
import com.cun.service.UserService;
import com.cun.util.IOUtil;
import com.cun.util.PageUtil;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class AdminServlet
 */
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String type = "0";//0 -> admin; 1->teach; 2 ->stu
    private transient final Log log = LogFactory.getLog(AdminServlet.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		UserService service = new UserService();
		String ptype = request.getParameter("type");
		log.debug("op: "+ptype);
		if (ptype.equals("list")) {//列出所有admin
			String p = request.getParameter("page");
			Integer totalCount = service.getAllUserNum(type);
			Page page =  PageUtil.createPage(10, totalCount, Integer.valueOf(p));
			List<Object> admins = service.getAllUser(page, type);
			request.setAttribute("admins", admins);
			request.setAttribute("page", page);
			request.getRequestDispatcher("WEB-INF/sys/admin.jsp").forward(request, response);
			return;
		}else if (ptype.equals("add")){
			response.setContentType("text/plain;charset=utf-8");
			PrintWriter out = response.getWriter();
			String uString = IOUtil.readJSONString(request);
			log.debug(uString);
			JSONObject jsonObject = JSONObject.fromObject(uString);
			JSONObject object = new JSONObject();
			String username = (String) jsonObject.get("username");
			String password = (String) jsonObject.get("password");
			User user = new User(username, password);
			User u = service.getUserInfo(user);
			if (u!=null) {
				object.put("code", "1");
			}else {
				user.setType("0");
				user.setStatus("yes");
				user.setCreatetime(new Timestamp(System.currentTimeMillis()));
				try {
					service.AddUser(user);
					object.put("code", "0");
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			out.write(object.toString());
			return;
		}/*else if (type.equals("edit")){
			String id = request.getParameter("id");
			User user = service.getUserById(id);
			log.debug(user);
			request.setAttribute("user", user);
			request.getRequestDispatcher("WEB-INF/connoisseurupdate.jsp").forward(request, response);
			return;
		}*/else if (ptype.equals("status")) {
			response.setContentType("text/plain;charset=utf-8");
			PrintWriter out = response.getWriter();
			String id = request.getParameter("id");
			User user = service.getUserById(id);
			JSONObject object = new JSONObject();
			if (user.getStatus().equals("yes")) {
				user.setStatus("no");
			}else if (user.getStatus().equals("no")) {
				user.setStatus("yes");
			}
			try {
				service.updateUser(user);
				object.put("code", "0");
				object.put("status", user.getStatus());
			} catch (Exception e) {
				// TODO: handle exception
				object.put("code", "1");
			}
			out.write(object.toString());
			return;
		}else if (ptype.equals("del")){
			
			response.setContentType("text/plain;charset=utf-8");
			PrintWriter out = response.getWriter();
			String id = request.getParameter("id");
			User user = service.getUserById(id);
			JSONObject object = new JSONObject();
			try {
				service.delUser(user);
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
