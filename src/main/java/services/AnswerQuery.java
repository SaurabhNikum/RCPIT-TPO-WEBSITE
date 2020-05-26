package services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connectDB.DBconnect;

/**
 * Servlet implementation class AnswerQuery
 */
@WebServlet("/AnswerQuery")
public class AnswerQuery extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(AnswerQuery.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AnswerQuery() {
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
		try {
			String answers = request.getParameter("answer");
			String query_id = request.getParameter("query_id");
			
			Connection conn = DBconnect.getConnect();

			PreparedStatement ps1 = conn.prepareStatement("update query set ANSWER=? where query_id=?");
			ps1.setString(1, answers);
			ps1.setString(2, query_id);
			int n = ps1.executeUpdate();
			if (n>=1) 
			{
				request.getSession().setAttribute("msg", "Answered Successfully..!!");
				response.sendRedirect("viewQueriesTPO.jsp");

			} 
			else 
			{
				request.getSession().setAttribute("msg", "Failed To Update..!!");
				response.sendRedirect("viewQueriesTPO.jsp");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			log.error("Could not answer the query : {}", e);
			request.getSession().setAttribute("msg", "Failed To Update..!!");
			response.sendRedirect("viewQueriesTPO.jsp");
		}
	}

}
