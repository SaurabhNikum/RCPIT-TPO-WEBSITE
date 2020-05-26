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

@WebServlet("/EditProfile")
public class EditProfile extends HttpServlet {

	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(EditProfile.class);

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("index.jsp");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse response)
			throws ServletException, IOException {
		RequestMap request = Utility.getSafeParams(req);
		
		
		if (!Auth.getRole(request.getSession()).equals("STUDENT")) {
			response.sendRedirect("studentLogin.jsp");
			return;
		}
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);		
		String names = request.getParameter("name");
		String rollnos = request.getParameter("rollno");
		String branchs = request.getParameter("branch");
		String divs = request.getParameter("div");
		String emails = request.getParameter("email");
		String mobnos = request.getParameter("mobno");
		String CGPAs = request.getParameter("cgpa");
		String sscs = request.getParameter("ssc");
		String hscs = request.getParameter("hsc");
		String activebacklogs = request.getParameter("activebacklog");
		String addresss = request.getParameter("address");
		String gaps = request.getParameter("gap");
		try {
			
			Connection conn = DBconnect.getConnect();
			PreparedStatement ps = conn.prepareStatement("select * from student where (email_id=? or mobile_no=?) and student_id!=?");
			ps.setString(1, emails);
			ps.setString(2, mobnos);
			ps.setString(3, request.getSession().getAttribute("user_id").toString());
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				if(rs.getString("email_id").equals(emails))
					request.getSession().setAttribute("msg", "Email already exists");
				if(rs.getString("mobile_no").equals(mobnos))
					request.getSession().setAttribute("msg", "Mobile Number already exists");
				response.sendRedirect("editProfile.jsp");
				return;
			}else {
				ps = conn.prepareStatement("select * from student where branch=? and roll_no=? and student_id!=?");
				ps.setString(1, branchs);
				ps.setString(2, rollnos);
				ps.setString(3, request.getSession().getAttribute("user_id").toString());
				ResultSet rs1 = ps.executeQuery();
				if (rs1.next()) {
					request.getSession().setAttribute("msg", "Roll No "+rollnos+" already exists in "+branchs+" branch");
					response.sendRedirect("editProfile.jsp");
					return;
				}
			}
			
			String sql = "update student set name=?, roll_no=?, branch=?, student.div=?, email_id=?, mobile_no=?, cgpa=?, ssc_marks=?, hsc_marks=?, ACTIVE_BACKLOG=?, GAP=?, ADDRESS=? where student_id=?";
			ps = conn
					.prepareStatement(sql);
			ps.setString(1, names);
			ps.setString(2, rollnos);
			ps.setString(3, branchs);
			ps.setString(4, divs);
			ps.setString(5, emails);
			ps.setString(6, mobnos);
			ps.setString(7, CGPAs);
			ps.setString(8, sscs);
			ps.setString(9, hscs);
			ps.setString(10, activebacklogs);
			ps.setString(11, gaps);
			ps.setString(12, addresss);
			ps.setString(13, request.getSession().getAttribute("user_id").toString());
			int n = ps.executeUpdate();
			log.info("completed Updation");
			if (n >= 1) {
				request.getSession().setAttribute("ROLL_NO", rollnos);
				request.getSession().setAttribute("BRANCH", branchs);
				request.getSession().setAttribute("msg", "Updated..!!");
				response.sendRedirect("editProfile.jsp");
			} else {
				request.getSession().setAttribute("msg", "Can not Update..!!");
				response.sendRedirect("editProfile.jsp");
			}
		} catch (Exception e) {
			log.error("Could not edit profile : {}", e);
			request.getSession().setAttribute("msg", "Can not Update..!!");
			response.sendRedirect("editProfile.jsp");
		}
	}
}
