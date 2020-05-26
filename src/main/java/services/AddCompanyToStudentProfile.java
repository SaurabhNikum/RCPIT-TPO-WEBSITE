package services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connectDB.DBconnect;


/**
 * Servlet implementation class AddCompanyToStudentProfile
 */
@WebServlet("/AddCompanyToStudentProfile")
public class AddCompanyToStudentProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(AddCompanyToStudentProfile.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddCompanyToStudentProfile() {
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
		String rollnos = request.getParameter("rollno");
		String branchs = request.getParameter("branch");
		String cnames = request.getParameter("cname");
		String packages = request.getParameter("package");
		request.getSession().setAttribute("branch", branchs);
		try {
			Connection conn = DBconnect.getConnect();
			PreparedStatement ps;
			int[] rolls = null;
			try {
				rolls = Arrays.stream(rollnos.replaceAll(" ", "").split(",")).mapToInt(Integer::parseInt).toArray();
			} catch (NumberFormatException e) {
				request.getSession().setAttribute("msg", "Please specify numbers with comma separated..!!");
				request.getSession().setAttribute("rolls", rollnos);
				response.sendRedirect("addCompanyToStudentProfile.jsp");
				return;
			}
			String splits = IntStream.of(rolls).mapToObj(Integer::toString).collect(Collectors.joining(",")).toString();
			//System.out.println("splits " + splits);
			request.getSession().setAttribute("rolls", splits);
			int n1 = 0;
			String sql = "UPDATE STUDENT SET PACKAGE = CONCAT_WS(', ', PACKAGE, ?) , SELECTED_IN = CONCAT_WS(', ', SELECTED_IN, ?) WHERE ROLL_NO in ("
					+ splits + ") AND BRANCH =? AND coalesce(SELECTED_IN,'') not like '%" + cnames + "%'";
			ps = conn.prepareStatement(sql);
			ps.setString(1, packages);
			ps.setString(2, cnames);
			ps.setString(3, branchs);
			n1 = ps.executeUpdate();
			int count = 0;
			if (rolls.length>n1) {
				sql = "SELECT COUNT(ROLL_NO) FROM STUDENT WHERE ROLL_NO in (" + splits + ") AND BRANCH ='" 
						+ branchs + "'";
				ResultSet rs = conn.createStatement().executeQuery(sql);
				if (rs.next()) {
					count = rs.getInt(1);
				}
				if(rolls.length==count && count>1) {
					request.getSession().setAttribute("msg", "Successed..");
					request.getSession().removeAttribute("rolls");
					request.getSession().removeAttribute("branch");
					response.sendRedirect("addCompanyToStudentProfile.jsp");
					return;
				}
				if(n1==0 && count>0) {
					request.getSession().setAttribute("msg", count + " Records updated");
					response.sendRedirect("addCompanyToStudentProfile.jsp");
					return;
				}
			}
			if (n1 >= 1) {
				if (n1 == rolls.length) {
					request.getSession().removeAttribute("rolls");
					request.getSession().removeAttribute("branch");
					request.getSession().setAttribute("msg", "Successfully Added..");
				}else
					request.getSession().setAttribute("msg", count + " Records updated");
				response.sendRedirect("addCompanyToStudentProfile.jsp");
			} else {
				request.getSession().setAttribute("msg", "Nothing Updated! Please try again..");
				response.sendRedirect("addCompanyToStudentProfile.jsp");
			}
		} catch (Exception e) {
			log.error("Could not add company to student profile : {}", e);
			request.getSession().setAttribute("msg", "Error! Please try again..");
			response.sendRedirect("addCompanyToStudentProfile.jsp");
		}
	}

}