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

import connectDB.*;

/**
 * Servlet implementation class SortStudents
 */
@WebServlet("/SortStudents")
public class SortStudents extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(SortStudents.class);
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SortStudents() {
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
		float ssc = Float.parseFloat(request.getParameter("ssc"));
		float hsc = Float.parseFloat(request.getParameter("hsc"));
		float cgpa = Float.parseFloat(request.getParameter("cgpa"));
		int activebacklogs = Integer.parseInt(request.getParameter("activebacklog"));
		int gaps = Integer.parseInt(request.getParameter("gap"));
		UserInfo.setSsc(ssc);
		UserInfo.setHsc(hsc);
		UserInfo.setCgpa(cgpa);
		UserInfo.setActiveBacklogs(activebacklogs);
		UserInfo.setGaps(gaps);
		UserInfo.setBranch(eligibles!=null?eligibles:new String[0]);
		response.sendRedirect("sortStudent.jsp");
	}

}
