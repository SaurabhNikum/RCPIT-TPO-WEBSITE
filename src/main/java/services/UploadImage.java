package services;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connectDB.DBconnect;

/**
 * Servlet implementation class AddCompany
 */
@WebServlet("/UploadImage")
public class UploadImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(UploadImage.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UploadImage() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (!Auth.getRole(request.getSession()).equals("STUDENT")) {
			response.sendRedirect("studentLogin.jsp");
			return;
		}
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);
		File file;
		int maxFileSize = 5000 * 1024;
		int maxMemSize = 5000 * 1024;
		getServletContext();
		String filePath = services.Properties.getDir();

		// Verify the content type
		String contentType = request.getContentType();

		if ((contentType.indexOf("multipart/form-data") >= 0)) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// maximum size that will be stored in memory
			factory.setSizeThreshold(maxMemSize);

			// Location to save data that is larger than maxMemSize.
			factory.setRepository(new File(services.Properties.getDir()));

			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);

			// maximum file size to be uploaded.
			upload.setSizeMax(maxFileSize);

			try {
				// Parse the request to get file items.
				List fileItems = upload.parseRequest(request);

				// Process the uploaded file items
				Iterator i = fileItems.iterator();

				while (i.hasNext()) {
					FileItem fi = (FileItem) i.next();
					if (!fi.isFormField()) {
						fi.getFieldName();
						String fileName = fi.getName();
						fi.isInMemory();
						fi.getSize();
						Long date = System.currentTimeMillis();
						fileName = date + "-" + fileName;
						// Write the file
						if (fileName.lastIndexOf("\\") >= 0) {
							file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\")));
						} else {
							file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1));
						}
						fi.write(file);
						log.info("Uploaded Filename: " + filePath + fileName);
						Connection conn = DBconnect.getConnect();
						PreparedStatement ps = conn.prepareStatement("update student set image = ? where student_id = ?");
						ps.setString(1, fileName);
						ps.setString(2, request.getSession().getAttribute("user_id").toString());
						ps.executeUpdate();
					}
				}
				request.getSession().setAttribute("msg", "Success");
			} catch (Exception ex) {
				log.error("Could not upload image : {}", ex);
				request.getSession().setAttribute("msg", "Please try later");
			}
		}
		response.sendRedirect("uploadPic.jsp");

	}

}
