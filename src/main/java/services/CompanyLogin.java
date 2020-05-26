package services;

import java.io.IOException;
import java.security.MessageDigest;
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
 * Servlet implementation class CompanyLogin
 */
@WebServlet("/CompanyLogin")
public class CompanyLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(CompanyLogin.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CompanyLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse response)
			throws ServletException, IOException {
		RequestMap request = Utility.getSafeParams(req);
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);		
		String email=request.getParameter("email");
		String pass=request.getParameter("password");
		try
		{
	        MessageDigest digest = MessageDigest.getInstance("SHA-256");
	        byte[] hash = digest.digest(pass.getBytes("UTF-8"));
	        StringBuffer hexString = new StringBuffer();

	        for (int i = 0; i < hash.length; i++) {
	            String hex = Integer.toHexString(0xff & hash[i]);
	            if(hex.length() == 1) hexString.append('0');
	            hexString.append(hex);
	        }
	        
			Connection conn=DBconnect.getConnect();
			PreparedStatement ps = conn.prepareStatement("select * from company where EMAIL_ID=? and PASSWORD=?");
			ps.setString(1, email);
			ps.setString(2, hexString.toString());
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				UserInfo.setEmail(rs.getString("EMAIL_ID"));
				HttpSession session = request.getSession();
				session.setAttribute("user_id", rs.getString("COMPANY_ID"));
				session.setAttribute("user", rs.getString("NAME"));
				session.setAttribute("role", "COMPANY");
				response.sendRedirect("menuForCompany.jsp");
			}
			else
			{
				request.getSession().setAttribute("msg", "Wrong User Credentials..!!");
				response.sendRedirect("companyLogin.jsp");
			}
		}catch (Exception e){
			log.error("Could not login to company : {}", e);
			request.getSession().setAttribute("msg", "Please try later..!!");
			response.sendRedirect("companyLogin.jsp");
		}

	}

}
