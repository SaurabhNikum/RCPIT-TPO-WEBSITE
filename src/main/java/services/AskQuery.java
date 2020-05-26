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
 * Servlet implementation class AskQuery
 */
@WebServlet("/AskQuery")
public class AskQuery extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(AskQuery.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AskQuery() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 request.getSession().setAttribute("msg", "Please try again..!!");
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
		String querys = request.getParameter("query");
		//System.out.println("querys"+querys);

		String rollno = request.getSession().getAttribute("ROLL_NO").toString();
		//System.out.println("roll no"+rollno);

		String branchs = null;

		String names = null;
		try {
			Connection conn = DBconnect.getConnect();

			PreparedStatement ps = conn.prepareStatement("select * from student where ROLL_NO=?");
			ps.setString(1, rollno);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				// UserInfo.setRollNo(rs.getString("ROLL_NO"));
				// response.sendRedirect("menuForStudent.jsp");

				branchs = rs.getString("BRANCH");
//				System.out.println("branch"+branchs);

				names = rs.getString("NAME");
//				System.out.println("name"+names);
//				System.out.println("hello shweta");
				PreparedStatement ps1 = conn.prepareStatement("replace into query (QUERIES, ROLL_NO, BRANCH, NAME, STATUS, ACTION) values (?,?,?,?,'','')");
				ps1.setString(1, querys);
				ps1.setString(2, rollno);
				ps1.setString(3, branchs);
				ps1.setString(4, names);
//				System.out.println("hello shweta");
//				PreparedStatement ps2 = conn.prepareStatement("update query set BRANCH=? where ROLL_NO=?");
//				ps2.setString(1, branchs);
//				ps2.setString(2, rollno);
//				System.out.println("hello shweta3");
//				PreparedStatement ps3 = conn.prepareStatement("update query set NAME=? where ROLL_NO=?");
//				ps3.setString(1, names);
//				ps3.setString(2, rollno);
//				System.out.println("hello shweta4");
//				System.out.println("querys"+querys);
//				System.out.println("roll no"+rollno);
//				System.out.println("branch"+branchs);
//				System.out.println("name"+names);
				int n1 = ps1.executeUpdate();
				//int n2 = ps2.executeUpdate();
				//int n3 = ps3.executeUpdate();

				if (n1 >= 1) {
					 request.getSession().setAttribute("msg", "Query Asked");
					response.sendRedirect("viewAnsweredQueries.jsp");
				} else {
					 request.getSession().setAttribute("msg", "Please try again..!!");
					response.sendRedirect("askQueries.jsp");
				}
			}
		} catch (Exception e) {
			log.error("Could not ask query : {}", e);
			 request.getSession().setAttribute("msg", "Please try again..!!");
			response.sendRedirect("askQueries.jsp");
		}
	}

}
