package com.cun.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cun.model.User;
import com.cun.service.UserService;
import com.cun.util.IOUtil;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class ChangePwdServlet
 */
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
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
		UserService service = new UserService();
		if (type.equals("update_pwd")) {//修改密码
			response.setContentType("text/plain;charset=utf-8");
			JSONObject object = new JSONObject();
			PrintWriter out = response.getWriter();
			String uString = IOUtil.readJSONString(request);
			JSONObject jsonObject = JSONObject.fromObject(uString);
			
			String id = jsonObject.getString("id");
			String pwd1 = jsonObject.getString("pwd1");
			String pwd2 = jsonObject.getString("pwd2");
			String pwd3 = jsonObject.getString("pwd3");
			
			User user = service.getUserById(id);
			if (pwd1!=null&&pwd1.equals(user.getPassword())) {
				if (pwd2.equals(pwd3)) {
					user.setPassword(pwd2);
					try {
						service.updateUser(user);
						
						HttpSession session = request.getSession();
						session.removeAttribute("user");
						
						object.put("code", "0");
					} catch (Exception e) {
						// TODO: handle exception
						object.put("code", "3");
					}
				}else {
					object.put("code", "2");
				}
			}else {
				object.put("code", "1");
			}
			out.write(object.toString());
			return;
		}else if (type.equals("update_info")) {
			response.setContentType("text/plain;charset=utf-8");
			JSONObject object = new JSONObject();
			PrintWriter out = response.getWriter();
			String uString = IOUtil.readJSONString(request);
			JSONObject jsonObject = JSONObject.fromObject(uString);
			System.out.println(jsonObject);
			String id = jsonObject.getString("id");
			String phone = jsonObject.getString("phone");
			String email = jsonObject.getString("email");
			String sex = jsonObject.getString("sex");
			String name = jsonObject.getString("name");
			User user = service.getUserById(id);
			if (user.getType().equals("2")) {
				user.setBcid(jsonObject.getString("bcid"));
			}
			user.setName(name);
			user.setPhone(phone);
			user.setSex(sex);
			user.setEmail(email);
			
			try {
				service.updateUser(user);
				object.put("code", "0");
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("user", user);
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
