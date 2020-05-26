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
@WebServlet("/ChangePassword")
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(ChangePassword.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangePassword() {
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
		
		if (!Auth.getRole(request.getSession()).equals("COMPANY")) {
			if (!Auth.getRole(request.getSession()).equals("STUDENT")) {
				response.sendRedirect("index.jsp");
				return;
			}
		}
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);
		String currentPassword = request.getParameter("currentpassword");
		String changePasswordss = request.getParameter("confirmpassword");
		String existingPassword = null;
		try {
			
	        MessageDigest currentDigest = MessageDigest.getInstance("SHA-256");
	        byte[] currentHash = currentDigest.digest(currentPassword.getBytes("UTF-8"));
	        StringBuffer currentHexString = new StringBuffer();

	        for (int i = 0; i < currentHash.length; i++) {
	            String hex = Integer.toHexString(0xff & currentHash[i]);
	            if(hex.length() == 1) currentHexString.append('0');
	            currentHexString.append(hex);
	        }
	        
	        MessageDigest changeDigest = MessageDigest.getInstance("SHA-256");
	        byte[] changeHash = changeDigest.digest(changePasswordss.getBytes("UTF-8"));
	        StringBuffer changeHexString = new StringBuffer();

	        for (int i = 0; i < changeHash.length; i++) {
	            String hex = Integer.toHexString(0xff & changeHash[i]);
	            if(hex.length() == 1) changeHexString.append('0');
	            changeHexString.append(hex);
	        }
	        
			Connection conn = DBconnect.getConnect();
			Statement statement = conn.createStatement();
			String sql="";
			if(Auth.getRole(request.getSession()).equals("COMPANY"))
				sql= "select * from company where name = '" + request.getSession().getAttribute("user")
					+ "' AND password='" + currentHexString.toString() + "'";
			else
				sql = "select * from student where EMAIL_ID = '" + request.getSession().getAttribute("user")
					+ "' AND password='" + currentHexString.toString() + "'";
			ResultSet resultSet = statement.executeQuery(sql);
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
			}

			PreparedStatement ps;
			if(Auth.getRole(request.getSession()).equals("COMPANY"))
				ps= conn.prepareStatement("update company set password = ? where name=?");
			else
				ps = conn.prepareStatement("update student set password = ? where EMAIL_ID=?");
			ps.setString(1, changeHexString.toString());
			ps.setString(2, request.getSession().getAttribute("user").toString());
			int n = ps.executeUpdate();
			if (n >= 1) {
				// UserInfo.setAccNo(rs.getString("accno"));
				request.getSession().setAttribute("msg", "Password changed succesfully!");
				response.sendRedirect("password.jsp");
			} else {
				request.getSession().setAttribute("msg", "Can not change password try again..!!");
				response.sendRedirect("password.jsp");
			}
		} catch (Exception e) {
			log.error("Could not change the password : {}", e);
			request.getSession().setAttribute("msg", "Can not change password try again..!!");
			response.sendRedirect("password.jsp");
		}

	}

}
