package services;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import connectDB.DBconnect;

/**
 * Servlet implementation class StudentLogin
 */
@WebServlet("/ForgotPassword")
public class ForgotPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	final private static Logger log = LoggerFactory.getLogger(ForgotPassword.class);

	static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	static SecureRandom rnd = new SecureRandom();
	
	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
			response.sendRedirect("index.jsp");
		}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse response)
			throws ServletException, IOException {
		RequestMap request = Utility.getSafeParams(req);
		log.info("User: {}, data:{}",request.getSession().getAttribute("user"),request);		
		
		String table = "student";
		String userIdColumnName = "student_id";
		String redirectLoginPage = "studentLogin.jsp";
		String redirectSelf = "forgotPassword.jsp";
		String resetLinkPage = "forgotPassword.jsp?";
		if(request.getParameter("user")!=null && request.getParameter("user").equals("COMPANY")) {
			table = "company";
			userIdColumnName = "company_id";
			redirectLoginPage = "companyLogin.jsp";
			redirectSelf = "forgotPassword.jsp?user=COMPANY";
			resetLinkPage = "forgotPassword.jsp?user=COMPANY&";
		}
		String email = request.getParameter("email");
		String pass = request.getParameter("password");
		String forgotPasswordAuthTOken = request.getParameter("forgotPasswordAuthTOken");

		if (pass == null) {
			try {
				Connection conn = DBconnect.getConnect();
				PreparedStatement ps = conn.prepareStatement("select * from "+table+" where email_id=?");
				ps.setString(1, email);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
					String url = req.getRequestURL().toString();
					String baseURL = url.substring(0, url.length() - req.getRequestURI().length())
							+ req.getContextPath() + "/";

					StringBuilder sb = new StringBuilder(200);
					for (int i = 0; i < 200; i++)
						sb.append(AB.charAt(rnd.nextInt(AB.length())));

					String resetCode = sb.toString() + System.currentTimeMillis();
					
					String userID = rs.getString(userIdColumnName);
					ps = conn.prepareStatement("update "+table+" set forgotPasswordAuthTOken=? where "+userIdColumnName+"=?");
					ps.setString(1, resetCode);
					ps.setString(2, userID);
					if (ps.executeUpdate() == 0) {
						request.getSession().setAttribute("msg", "Something went Wrong.. Please try later");
						response.sendRedirect(redirectSelf);
						return;
					}
					final String to = request.getParameter("email");
					final String sub = "FORGOT PASSWORD - RCPIT-TPO";
					final String msg = "Click the below link to reset the password \n " + baseURL
							+ "/"+resetLinkPage+"forgotPasswordAuthTOken=" + resetCode;
					final String from = Properties.getGoogleAccountEmail();
					final String password = Properties.getGoogleAccountPassword();
					String host = "smtp.gmail.com";
					java.util.Properties props = new java.util.Properties();
					props.put("mail.smtp.host", host);
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.starttls.enable", "true");
					props.put("mail.user", from);
					props.put("mail.password", password);
					props.put("mail.smtp.port", "587");
					Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
						// @Override
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(from, password);
						}

					});
					String result = null;
					try {
						MimeMessage message = new MimeMessage(mailSession);
						message.setFrom(new InternetAddress(from));
						final InternetAddress addressTo = new InternetAddress(to);
						message.setRecipient(Message.RecipientType.TO, addressTo);
						message.setSubject(sub);
						message.setText(msg);
						log.info("sending mail");
						Transport.send(message);
						result = "Please check your email for reset password link";
						log.info("Done");
					} catch (Exception e) {
						log.error("Could not change password Something Went Wrong: {}", e);
						result = "Something went wrong, please try later..";
					}
					request.getSession().setAttribute("msg", result);
					response.sendRedirect(redirectSelf);
					return;

				}else {
					request.getSession().setAttribute("msg", "Email not exists...");
					response.sendRedirect(redirectSelf);
					return;
				}
			} catch (Exception e) {
				log.error("Could not change password Something Went Wrong: {}", e);
				request.getSession().setAttribute("msg", "Something went wrong, please try later..");
				response.sendRedirect(redirectSelf);
				return;
			}
		}
		try {


			Connection conn = DBconnect.getConnect();
			PreparedStatement ps = conn.prepareStatement("select * from "+table+" where forgotPasswordAuthTOken=?");
			ps.setString(1, forgotPasswordAuthTOken);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				String userID = rs.getString(userIdColumnName);
				ps = conn.prepareStatement("update "+table+" set password=? where "+userIdColumnName+"=?");
				ps.setString(1, pass);
				ps.setString(2, userID);
				if (ps.executeUpdate() >= 1) {
					request.getSession().setAttribute("msg", "Password Changed Successfully");
					response.sendRedirect(redirectLoginPage);
				} else {
					request.getSession().setAttribute("msg", "Something Went Wrong. Please try later..");
					response.sendRedirect(redirectLoginPage);
				}
			} else {
				request.getSession().setAttribute("msg", "Something Went Wrong. Please try later..");
				response.sendRedirect(redirectLoginPage);
			}
		} catch (Exception e) {
			log.error("Could not change password Something Went Wrong: {}", e);
		}
	}

}
