package services;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet("/SharedFiles")
public class SharedFiles extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(SharedFiles.class);
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse response)
			throws ServletException, IOException {
		RequestMap request = Utility.getSafeParams(req);
		
		if (!Auth.getRole(request.getSession()).equals("COMPANY")) {
			response.sendRedirect("companyLogin.jsp");
			return;
		}
		
		try {

			String delete_file_id = request.getParameter("delete_file_id");
			Connection conn = DBconnect.getConnect();
			PreparedStatement ps = conn.prepareStatement("delete from file where file_id=?");
			ps.setString(1, delete_file_id);
			ps.execute("delete from file where file_id=" + delete_file_id);
			req.getSession().setAttribute("msg", "Successfully Deleted");
			response.sendRedirect("sharedFiles.jsp");
		} catch (Exception e) {
			log.error("Could not shre file : {}", e);
			req.getSession().setAttribute("msg", "Please try later");
			response.sendRedirect("sharedFiles.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		if (!Auth.getRole(request.getSession()).equals("COMPANY")) {
			response.sendRedirect("companyLogin.jsp");
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
				boolean uploadCompleted = false;
				String fileName = null;
				String type = null;
				String desc = null;
				while (i.hasNext()) {
					FileItem fi = (FileItem) i.next();
					if (fi.getFieldName().equals("description")) {
						desc = new String(fi.get());
					}
					if (!fi.isFormField()) {
						fileName = fi.getName();
						fi.isInMemory();
						fi.getSize();
						type = fi.getContentType();
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
					}
				}

				Connection conn = DBconnect.getConnect();
				PreparedStatement ps = conn.prepareStatement("insert into file (company_id, file, type, description) values(?,?,?,?)");
				ps.setString(1, request.getSession().getAttribute("user_id").toString());
				ps.setString(2, Utility.getSafeParam(fileName));
				ps.setString(3, Utility.getSafeParam(type));
				ps.setString(4, Utility.getSafeParam(desc));
				ps.execute();
				request.getSession().setAttribute("msg", "Successfully Uploaded");
				response.sendRedirect("sharedFiles.jsp");

			} catch (Exception ex) {
				log.error("Could not shre file : {}", ex);
				request.getSession().setAttribute("msg", "Please try later");
				response.sendRedirect("sharedFiles.jsp");

			}
		}

	}

}
