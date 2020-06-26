package services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connectDB.DBconnect;
import connectDB.UserInfo;

/**
 * Servlet implementation class StudentLogin
 */
@WebServlet("/StudentLogin")
public class StudentLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(StudentLogin.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StudentLogin() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse response)
			throws ServletException, IOException {
		RequestMap request = Utility.getSafeParams(req);
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);

		String email = request.getParameter("email");
		String pass = request.getParameter("password");
		try {
			Connection conn = DBconnect.getConnect();
			PreparedStatement ps = conn.prepareStatement("select * from Student where EMAIL_ID=? and PASSWORD=?");
			ps.setString(1, email);
			ps.setString(2, pass);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				UserInfo.setRollNo(rs.getString("ROLL_NO"));
				UserInfo.setName(rs.getString("NAME"));
				UserInfo.setEmail(rs.getString("EMAIL_ID"));
				HttpSession session = request.getSession();
				session.setAttribute("ROLL_NO", rs.getString("ROLL_NO"));
				session.setAttribute("user_id", rs.getString("student_id"));
				session.setAttribute("BRANCH", rs.getString("BRANCH"));
				session.setAttribute("user", rs.getString("EMAIL_ID"));
				session.setAttribute("role", "STUDENT");
				session.setAttribute("name", rs.getString("NAME"));				
				response.sendRedirect("menuForStudent.jsp");
			} else {
				request.getSession().setAttribute("msg", "Wrong User Credentials..!!");
				response.sendRedirect("studentLogin.jsp");
			}
		} catch (Exception e) {
			log.error("Could not log in : {}", e);
			request.getSession().setAttribute("msg", "Please try later..!!");
			response.sendRedirect("studentLogin.jsp");
		}
	}

}
