package services;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connectDB.DBconnect;

/**
 * Servlet implementation class StudentRegistration
 */
@WebServlet("/StudentRegistration")
public class StudentRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(StudentRegistration.class);
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StudentRegistration() {
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
		 
		String names = request.getParameter("name");
		String rollnos = request.getParameter("rollno");
		String branchs = request.getParameter("branch");
		String divs = request.getParameter("div");
		String emails = request.getParameter("email");
		String passwords = request.getParameter("password");
		String mobnos = request.getParameter("mobno");
		String CGPAs = request.getParameter("cgpa");
		String sscs = request.getParameter("ssc");
		String hscs = request.getParameter("hsc");
		String activebacklogs = request.getParameter("activebacklog");
		String addresss = request.getParameter("address");
		String gaps = request.getParameter("gap");
		
		try {
			Connection conn = DBconnect.getConnect();
			PreparedStatement ps = conn.prepareStatement("select * from student where email_id=? or mobile_no=?");
			ps.setString(1, emails);
			ps.setString(2, mobnos);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				if(rs.getString("email_id").equals(emails))
					request.getSession().setAttribute("msg", "Email already exists");
				if(rs.getString("mobile_no").equals(mobnos))
					request.getSession().setAttribute("msg", "Mobile Number already exists");
				response.sendRedirect("studentRegister.jsp");
				return;
			}else {
				ps = conn.prepareStatement("select * from student where branch=? and roll_no=?");
				ps.setString(1, branchs);
				ps.setString(2, rollnos);
				ResultSet rs1 = ps.executeQuery();
				if (rs1.next()) {
					request.getSession().setAttribute("msg", "Roll No "+rollnos+" already exists in "+branchs+" branch");
					response.sendRedirect("studentRegister.jsp");
					return;
				}
			}
	        MessageDigest digest = MessageDigest.getInstance("SHA-256");
	        byte[] hash = digest.digest(passwords.getBytes("UTF-8"));
	        StringBuffer hexString = new StringBuffer();

	        for (int i = 0; i < hash.length; i++) {
	            String hex = Integer.toHexString(0xff & hash[i]);
	            if(hex.length() == 1) hexString.append('0');
	            hexString.append(hex);
	        }
			
			ps = conn.prepareStatement("insert into student values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

			ps.setString(1, null);
			ps.setString(2, names);
			ps.setString(3, rollnos);
			ps.setString(4, branchs);
			ps.setString(5, divs);
			ps.setString(6, emails);
			ps.setString(7, hexString.toString());
			ps.setString(8, mobnos);
			ps.setString(9, CGPAs);
			ps.setString(10, sscs);
			ps.setString(11, hscs);
			ps.setString(12, activebacklogs);
			ps.setString(13, addresss);
			ps.setString(14, null);
			ps.setString(15, null);
			ps.setString(16, "assets/img/find_user.png");
			ps.setString(17, null);
			ps.setString(18, null);
			ps.setString(19, gaps);
			int n = ps.executeUpdate();
			log.info("completed Registration");
			if (n >= 1) 
			{
				request.getSession().setAttribute("msg", "Registered..!!");
				// UserInfo.setAccNo(rs.getString("accno"));
				response.sendRedirect("studentLogin.jsp");
			} else {
				request.getSession().setAttribute("msg", "Can not Register..!!");
				response.sendRedirect("studentRegister.jsp");
			}
		} catch (Exception e) {
			log.error("Could not register : {}", e);
			request.getSession().setAttribute("msg", "Can not Register..!!");
			response.sendRedirect("studentRegister.jsp");
		}
	}

}
