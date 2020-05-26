package services;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connectDB.DBconnect;

/**
 * Servlet implementation class AddCompany
 */
@WebServlet("/ChangePassword1")
public class ChangePassword1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(ChangePassword1.class);
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangePassword1() {
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
		if (!Auth.getRole(request.getSession()).equals("ADMIN")) {
			response.sendRedirect("adminLogin.jsp");
			return;
		}
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);
		String cnames = request.getParameter("cname");
		String passwords = request.getParameter("password");
		try {
			
	        MessageDigest currentDigest = MessageDigest.getInstance("SHA-256");
	        byte[] currentHash = currentDigest.digest(passwords.getBytes("UTF-8"));
	        StringBuffer currentHexString = new StringBuffer();

	        for (int i = 0; i < currentHash.length; i++) {
	            String hex = Integer.toHexString(0xff & currentHash[i]);
	            if(hex.length() == 1) currentHexString.append('0');
	            currentHexString.append(hex);
	        }
	        
	        MessageDigest changeDigest = MessageDigest.getInstance("SHA-256");
	        byte[] changeHash = changeDigest.digest(passwords.getBytes("UTF-8"));
	        StringBuffer changeHexString = new StringBuffer();

	        for (int i = 0; i < changeHash.length; i++) {
	            String hex = Integer.toHexString(0xff & changeHash[i]);
	            if(hex.length() == 1) changeHexString.append('0');
	            changeHexString.append(hex);
	        }
	        
			Connection conn = DBconnect.getConnect();
			Statement statement = conn.createStatement();
			String sql="";
			if(Auth.getRole(request.getSession()).equals("ADMIN"))
				sql= "select * from company where NAME = '" + cnames + "' AND password='" + currentHexString.toString() + "'";
			//System.out.println("CNAME="+ cnames);
		//	else
			//	sql = "select * from student where EMAIL_ID = '" + request.getSession().getAttribute("user")
				//	+ "' AND password='" + currentHexString.toString() + "'";
	/*		ResultSet resultSet = statement.executeQuery(sql);
			if (resultSet.next()) {
				existingPassword = resultSet.getString("password");
			}
			
			if (existingPassword==null) {
				request.getSession().setAttribute("msg", "Current password is incorrect!");
				response.sendRedirect("password.jsp");
				return;
			}
			
			if (existingPassword.equals(changeHexString.toString())) {
				request.getSession().setAttribute("msg", "Old and New Password should not be same!");
				response.sendRedirect("password.jsp");
				return;
			}                 */

			PreparedStatement ps = null;
			if(Auth.getRole(request.getSession()).equals("ADMIN"))
				ps= conn.prepareStatement("update company set password = ? where name ='" + cnames + "'");
			ps.setString(1, changeHexString.toString());
		//	ps.setString(2, request.getSession().getAttribute("user").toString());
		//	else
			//	ps = conn.prepareStatement("update student set password = ? where student_id=?");

			int n = ps.executeUpdate();
			if (n >= 1) {
				// UserInfo.setAccNo(rs.getString("accno"));
				request.getSession().setAttribute("msg", "Password changed succesfully!");
				response.sendRedirect("password1.jsp");
			} else {
				request.getSession().setAttribute("msg", "Can not change password try again..!!");
				response.sendRedirect("password1.jsp");
			}
		} catch (Exception e) {
			log.error("Could not change password {}", e);
			request.getSession().setAttribute("msg", "Can not change password try again..!!");
			response.sendRedirect("password1.jsp");
		}

	}

}
