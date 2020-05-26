<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("addNotificationsForStudents_JSP"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>RCPIT, TPO</title>
</head>
<body>
	<%
		Statement statement = null;
		ResultSet resultSet = null;
	%>

	<%
		try {
			Connection conn = DBconnect.getConnect();
			statement = conn.createStatement();
			String query_id = request.getParameter("query_id");
			java.sql.PreparedStatement ps = conn.prepareStatement("delete from Query where query_id=?");
			ps.setString(1, query_id);
			int i = ps.executeUpdate();
			if (i == 1) {
				response.sendRedirect("viewQueriesTPO.jsp");
			}
		} catch (Exception e) {
			log.error("Could not view query : {}", e);
		}
	%>
</body>
</html>