package services;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.mail.internet.ContentType;
import javax.mail.internet.ParseException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Servlet implementation class AddCompany
 */
@WebServlet("/Download")
public class Download extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(Download.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Download() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse response)
			throws ServletException, IOException {
		RequestMap request = Utility.getSafeParams(req);
		
		if (!Auth.isValidUser(request.getSession()) || request.getParameter("file") == null || request.getParameter("type") == null) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN);
			return;
		}
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);
		PrintWriter out = response.getWriter();

		String filePath = services.Properties.getDir();

		String fileName = request.getParameter("file");

		response.setContentType(request.getParameter("type"));

		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
		try {
			int i;
			response.setContentType("APPLICATION/OCTET-STREAM");
			FileInputStream fileInputStream = new FileInputStream(filePath + fileName);
			while ((i = fileInputStream.read()) != -1) {
				response.getWriter().write(i);
			}
			fileInputStream.close();
			out.close();
		} catch (Exception ex) {
			log.error("Could not download the file : {}", ex);
			ex.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}

	}
	
}
