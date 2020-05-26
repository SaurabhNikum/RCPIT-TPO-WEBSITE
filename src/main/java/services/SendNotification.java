package services;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
import connectDB.UserInfo;

/**
 * Servlet implementation class AddCompany
 */
@WebServlet("/SendNotification")
public class SendNotification extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(SendNotification.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SendNotification() {
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

		if (!Auth.getRole(request.getSession()).equals("ADMIN")) {
			if (!Auth.getRole(request.getSession()).equals("COMPANY")) {
				response.sendRedirect("adminLogin.jsp");
				return;
			}
		}
		
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);

		String result;
		final String to = request.getParameter("to");
		final String to_company = request.getParameter("to_company");
		final String sub = request.getParameter("subject");
		final String msg = request.getParameter("msg");
		final String is_company = request.getParameter("is_company");
		final String from = Properties.getGoogleAccountEmail();
		final String pass = Properties.getGoogleAccountPassword();

		String host = "smtp.gmail.com";
		java.util.Properties props = new java.util.Properties();
		props.put("mail.smtp.host", host);// change accordingly
		// props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		//System.out.println("It is in mailProcess");
		props.put("mail.user", from);
		props.put("mail.password", pass);
		props.put("mail.smtp.port", "587");
		//System.out.println("It is in mailProcess2");
		Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
			// @Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(from, pass);
			}

		});
		try {
			//System.out.println("mailProcess3");
			MimeMessage message = new MimeMessage(mailSession);
			//System.out.println("mailProcess4");
			message.setFrom(new InternetAddress(from));
			//System.out.println("mailProcess5");

			Connection conn = DBconnect.getConnect();
			Statement statement = conn.createStatement();
			String sql = "select EMAIL_ID from student";
			ResultSet resultSet;
			switch (to) {
			case "PLACED":
				sql = "select EMAIL_ID from student where SELECTED_IN is not null";
				break;
			case "NON_PLACED":
				sql = "select EMAIL_ID from student where SELECTED_IN is null";
				break;
			case "PLACED_IN":
				sql = "select EMAIL_ID from student where SELECTED_IN like '%" + to_company + "%'";
				break;
			case "ELIGIBLE":
				sql = "select * from company where name = '" + to_company + "'";
				resultSet = statement.executeQuery(sql);
				String ssc = "60";
				String hsc = "60";
				String degree = "";
				String backlog="0";					
				String gap="0";
				String eligible_branch="";
			
				if (resultSet.next()) {
					ssc=resultSet.getString("SSC");
					hsc=resultSet.getString("HSC_DIPLOMA");
					degree=resultSet.getString("DEGREE");
					backlog=resultSet.getString("ACTIVE_BACKLOG");
					gap=resultSet.getString("GAP");			
					eligible_branch=resultSet.getString("ELIGIBLE_BRANCH");					
				}
				
				//System.out.println(ssc);System.out.println(hsc);System.out.println(degree);
				
				sql = "select EMAIL_ID from student where SELECTED_IN is null AND SSC_MARKS >= '"+
						ssc+"' AND HSC_MARKS >=  '"+hsc+"' AND CGPA >=  '"+degree+"' AND ACTIVE_BACKLOG <="+backlog+" AND GAP<="+gap+" AND BRANCH in ('"+eligible_branch.replaceAll(",", "','")+"') ";
				break;
			}
			if (is_company != null)
				message.addRecipients(Message.RecipientType.CC, InternetAddress.parse(Properties.getTPOEMail()));
			log.info("Sending Email to : ");
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				log.info(resultSet.getString("EMAIL_ID").toString());
				message.addRecipients(Message.RecipientType.TO,
						InternetAddress.parse(resultSet.getString("EMAIL_ID").toString()));
			}
			//log.info("mailProcess6");
			message.setSubject(sub);
			//log.info("mailProcess7");
			message.setText(msg);
			//log.info("mailProcess8");
			Transport.send(message);
			//log.info("mailProcess9");
			result = "Email Sent Sucessfully!";
			log.info("Done");

		} catch (Exception e) {
			log.error("Could not send mail : {}", e);
			result = "Unable to Send Email....!";
		}

		log.info(result);
		request.getSession().setAttribute("msg", result);
		if (is_company == null)
			response.sendRedirect("addNotificationsForStudents.jsp");
		else
			response.sendRedirect("notifyStudents.jsp");

	}

}