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
 * Servlet implementation class ViewSelectionProcess
 */
@WebServlet("/ViewSelectionProcess")
public class ViewSelectionProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(ViewSelectionProcess.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ViewSelectionProcess() {
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
		String cname = request.getParameter("cname");

		try {
			Connection conn = DBconnect.getConnect();
			PreparedStatement ps = conn.prepareStatement("select * from company where NAME=?");
			ps.setString(1, cname);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				UserInfo.setCname(rs.getString("NAME"));
				response.sendRedirect("viewSelectionProcess1.jsp");
			} else {
				request.getSession().setAttribute("msg", "Please try again..!!");
				response.sendRedirect("viewSelectionProcess.jsp");
			}
		} catch (Exception e) {
			log.error("Could not view selection process : {}", e);
			request.getSession().setAttribute("msg", "Error, Please try later..!!");
			response.sendRedirect("viewSelectionProcess.jsp");
		}
	}

}
