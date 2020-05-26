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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connectDB.DBconnect;
import connectDB.UserInfo;

/**
 * Servlet implementation class UpdateDriveDetails
 */
@WebServlet("/UpdateDriveDetails")
public class UpdateDriveDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(UpdateDriveDetails.class);
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateDriveDetails() {
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
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);
		String email_ids = request.getParameter("email_id");
		String dates = request.getParameter("date");
		String locations = request.getParameter("location");
		String sscs = request.getParameter("ssc");
		String hscs = request.getParameter("hsc");
		String cgpas = request.getParameter("cgpa");
		String activebacklogs = request.getParameter("activebacklog");
		String packages = request.getParameter("package");
		String processs = request.getParameter("process");
		String contacts = request.getParameter("contact");
		String addresss = request.getParameter("address");
		String infos = request.getParameter("info");
		String gaps = request.getParameter("gap");		
		
		
		try {
			Connection conn = DBconnect.getConnect();
			
			
			PreparedStatement ps1 = conn.prepareStatement("select * from company where (email_id=? or contact_number=?) and company_id!=?");
			ps1.setString(1, email_ids);
			ps1.setString(2, contacts);
			ps1.setString(3,request.getSession().getAttribute("user_id").toString());
			ResultSet rs = ps1.executeQuery();
			if (rs.next()) {
				if(rs.getString("email_id").equals(email_ids))
					request.getSession().setAttribute("msg", "Email already exists");
				else if(rs.getString("contact_number").equals(contacts))
					request.getSession().setAttribute("msg", "Mobile Number already exists");
				response.sendRedirect("updateDriveDetails.jsp");
				return;
			}
			
			String sql = "update company set EMAIL_ID=?, DRIVE_DATE=?, DRIVE_LOCATION=?, DEGREE=?, HSC_DIPLOMA=?, SSC=?, ACTIVE_BACKLOG=?, PACKAGE=?, SELECTION_PROCESS=?, INFORMATION=?, CONTACT_NUMBER=?, GAP=?, ADDRESS= ?, ELIGIBLE_BRANCH=? where company_id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email_ids);
			ps.setString(2, dates);
			ps.setString(3, locations);
			ps.setString(4, cgpas);
			ps.setString(5, hscs);
			ps.setString(6, sscs);
			ps.setString(7, activebacklogs);			
			ps.setString(8, packages);
			ps.setString(9,processs);
			ps.setString(10, infos);
			ps.setString(11, contacts);
			ps.setString(12, gaps);
			ps.setString(13, addresss);
			ps.setString(14, String.join(",",eligibles!=null?eligibles:new String[0]));			
			ps.setString(15, request.getSession().getAttribute("user_id").toString());

			int n1 = ps.executeUpdate();
			log.info("completed Updation by company");
			if (n1 >= 1) {
				request.getSession().setAttribute("msg", "Updated..!!");
				response.sendRedirect("updateDriveDetails.jsp");
			} else {
				request.getSession().setAttribute("msg", "Cannot update..!!");
				 response.sendRedirect("updateDriveDetails.jsp");
			}
		} catch (Exception e) {
			log.error("Could not update drive details : {}", e);
			request.getSession().setAttribute("msg", "Error, Please try later..!!");
			response.sendRedirect("updateDriveDetails.jsp");
		}
	}

}
