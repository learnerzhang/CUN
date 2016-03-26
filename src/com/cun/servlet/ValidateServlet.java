package com.cun.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.cun.model.User;
import com.cun.service.UserService;
import com.cun.util.IOUtil;
import com.cun.util.StringUtil;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class ValidateServlet
 */
public class ValidateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private transient Log log = LogFactory.getLog(ValidateServlet.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		/*String username = request.getParameter("username");
		String password = request.getParameter("password");
		String vcode = request.getParameter("vcode");
		log.info(username+":"+password+":"+vcode);*/
		response.setContentType("text/plain;charset=utf-8");
		JSONObject object = new JSONObject();
		
		PrintWriter out = response.getWriter();
		String uString = IOUtil.readJSONString(request);
		JSONObject jsonObject = JSONObject.fromObject(uString);
		log.info(uString);
		
		String vcode = (String) jsonObject.get("vcode");
		HttpSession session = request.getSession();
		String captcha = (String) session.getAttribute("captcha");
		if (!StringUtil.equalWithcode(captcha, vcode)) {
			log.info("验证码错误....");
			jsonObject.put("code", "1");
		}else {
			String username = (String) jsonObject.get("username");
			String password = (String) jsonObject.get("password");
			
			User user = new User(username, password);
			UserService service = new UserService();
			int rs = service.verifyUser(user);
			if (rs==0) {
				
				User u = service.getUserInfo(user);
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("user", u);
				
				object.put("code", "0");//ok
			}else if (rs==2) {
				object.put("code", "2");//no username
			}else if (rs==3) {
				object.put("code", "3");//no password
			}
		}
		out.write(object.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
