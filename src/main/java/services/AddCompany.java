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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connectDB.DBconnect;

/**
 * Servlet implementation class AddCompany
 */
@WebServlet("/AddCompany")
public class AddCompany extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(AddCompany.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddCompany() {
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
		String[] eligibles = req.getParameterValues("eligible");
		RequestMap request = Utility.getSafeParams(req);
		
		if (!Auth.getRole(request.getSession()).equals("ADMIN")) {
			response.sendRedirect("adminLogin.jsp");
			return;
		}
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);
		String names = request.getParameter("name");
		String informations = request.getParameter("information");
		String emails = request.getParameter("email");
		String passwords = request.getParameter("password");
		String dates = request.getParameter("date");
		String locations = request.getParameter("location");
		String packages = request.getParameter("package");
		String degrees = request.getParameter("degree");
		String hscs = request.getParameter("hsc");
		String sscs = request.getParameter("ssc");
		String selectionprocesss = request.getParameter("selectionprocess");
		String requirements = request.getParameter("requirement");
		String addresss = request.getParameter("address");
		String mobnos = request.getParameter("mobno");
		String activebacklogs = request.getParameter("activebacklog");	
		String gaps = request.getParameter("gap");	
	//	String eligibles = request.getParameter("eligible");		
		try {
			Connection conn = DBconnect.getConnect();
			PreparedStatement ps1 = conn.prepareStatement("select * from company where email_id=? or contact_number=? or name=?");
			ps1.setString(1, emails);
			ps1.setString(2, mobnos);
			ps1.setString(3, names);
			ResultSet rs = ps1.executeQuery();
			if (rs.next()) {
				if(rs.getString("email_id").equals(emails))
					request.getSession().setAttribute("msg", "Email already exists");
				if(rs.getString("contact_number").equals(mobnos))
					request.getSession().setAttribute("msg", "Contact Number already exists");
				if(rs.getString("name").equals(names))
					request.getSession().setAttribute("msg", "Company Name already exists");
				response.sendRedirect("addCompany.jsp");
				return;
			}
			
			PreparedStatement ps = conn.prepareStatement("insert into company values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, null);			
			ps.setString(2, names);
			ps.setString(3, informations);
			ps.setString(4, emails);
			ps.setString(5, passwords);
			ps.setString(6, dates);
			ps.setString(7, locations);
			ps.setString(8, packages);
			ps.setString(9, degrees);
			ps.setString(10, hscs);
			ps.setString(11, sscs);
			ps.setString(12, selectionprocesss);
			ps.setString(13, requirements);
			ps.setString(14, addresss);
			ps.setString(15, mobnos);
			ps.setString(16, null);
			ps.setString(17, activebacklogs);
			ps.setString(18, gaps);
			ps.setString(19, String.join(",",eligibles));
			int n = ps.executeUpdate();
			if (n >= 1) {

				request.getSession().setAttribute("msg", "Successfully Register..!!");
				// UserInfo.setAccNo(rs.getString("accno"));
				response.sendRedirect("viewCompanyTPO.jsp");
			} else {
				request.getSession().setAttribute("msg", "Can not Register..!!");
				response.sendRedirect("addCompany.jsp");
			}
		} catch (Exception e) {
			log.error("Could not add company : {}", e);
			request.getSession().setAttribute("msg", "Can not Register..!!");
			response.sendRedirect("addCompany.jsp");
		}

	}

}
