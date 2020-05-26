package services;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connectDB.DBconnect;

@WebServlet("/TPOStudentService")
public class TPOStudentService extends HttpServlet {

	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(TPOStudentService.class);
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendError(HttpServletResponse.SC_FORBIDDEN);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!Auth.getRole(request.getSession()).equals("ADMIN")) {
			response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
			return; 
		}
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);
		try {
			Connection conn = DBconnect.getConnect();
			Statement statement = conn.createStatement();
			statement.execute("TRUNCATE TABLE STUDENT");
			response.sendError(HttpServletResponse.SC_OK);
		}catch (Exception e) {
			log.error("Something server error : {}", e);
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}