package services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

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
 * Servlet implementation class AddFeedback
 */
@WebServlet("/AddFeedback")
public class AddFeedback extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(AddFeedback.class);	

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddFeedback() {
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
		String feed = request.getParameter("feedback");

		try {

			Connection conn = DBconnect.getConnect();

			PreparedStatement ps = conn.prepareStatement("insert into feedback values(?,?,?)");
			ps.setString(1, UserInfo.getRollNo());
			ps.setString(2, UserInfo.getName());
			ps.setString(3, feed);

			int n1 = ps.executeUpdate();
			if (n1 >= 1) {
				// UserInfo.setAccNo(rs.getString("accno"));
				response.sendRedirect("menuForStudent.jsp");
			} else {
				request.getSession().setAttribute("msg", "Something went wrong");
				response.sendRedirect("menuForStudent.jsp");
			}
		} catch (Exception e) {
			log.error("Could not add Feedback : {}", e);
			response.sendRedirect("menuForStudent.jsp");
		}
	}

}
