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
 * Servlet implementation class AddSuggestionsForStudents
 */
@WebServlet("/AddSuggestionsForStudents")
public class AddSuggestionsForStudents extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(AddSuggestionsForStudents.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddSuggestionsForStudents() {
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
		
		String suggest = request.getParameter("suggestion");
		String names = request.getParameter("name");

		try {
			Connection conn = DBconnect.getConnect();
			PreparedStatement ps = conn.prepareStatement("insert into suggestions values (?,?)");
			ps.setString(2, suggest);
			ps.setString(1, names);

			int n1 = ps.executeUpdate();
			if (n1 >= 1) {
				// UserInfo.setAccNo(rs.getString("accno"));
				request.getSession().setAttribute("msg", "Done with adding the suggestions");
				response.sendRedirect("loginAsTeacher.jsp");
			} else {
				request.getSession().setAttribute("msg", "Please try later..!!");
				response.sendRedirect("loginAsTeacher.jsp");
			}
		} catch (Exception e) {
			log.error("Could not add Suggestion for students : {}", e);
			request.getSession().setAttribute("msg", "Please try later..!!");
			response.sendRedirect("loginAsTeacher.jsp");
		}
	}

}
