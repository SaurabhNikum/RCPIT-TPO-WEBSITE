<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="services.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("answerQuery_JSP"); %>
<%
	if (!Auth.getRole(session).equals("ADMIN")) {
		response.sendRedirect("adminLogin.jsp");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>RCPIT, TPO</title>
<!-- meta tags -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="keywords"
	content="Art Sign Up Form Responsive Widget, Audio and Video players, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, 
		Flat Web Templates, Login Sign-up Responsive Web Template, Smartphone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design" />
<!-- /meta tags -->
<!-- custom style sheet -->
<link href="css/style.css" rel="stylesheet" type="text/css" />
<!-- /custom style sheet -->
<!-- fontawesome css -->
<link href="css/fontawesome-all.css" rel="stylesheet" />
<!-- /fontawesome css -->
<!-- google fonts-->
<link
	href="//fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- /google fonts-->

</head>


<body>



	<h1 style="color: orange; text-shadow: 0.5px 0.5px 0.5px red;">R.
		C. Patel Institute of Technology, Shirpur</h1>
	<div class=" w3l-login-form">
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Welcome</h2>
		<form action="AnswerQuery" method="POST">

			<div class=" w3l-form-group">
				<label>Query</label>
				<div class="group">

					<%
						Statement statement = null;
						ResultSet resultSet = null;
						String query = "";
						try {
							Connection conn = DBconnect.getConnect();
							statement = conn.createStatement();
							String sql = "select * from query where query_id=" + request.getParameter("query_id");
							resultSet = statement.executeQuery(sql);
							if (resultSet.next()) {
								query = resultSet.getString("queries");
							}
						} catch (Exception e) {
							log.error("Could not answer query : {}", e);
						}
					%>
					<p ><%=query%> </p>
					<input type="text" name="query_id"
						value="<%=request.getParameter("query_id")%>"
						required="required" readonly hidden/>

				</div>
				<div class=" w3l-form-group">
					<label>Answer a Query:</label>
					<div class="group">
						<i class="fas fa-user"></i> <input type="text"
							class="form-control" placeholder="Type a your Answer "
							name="answer" required="required" />

					</div>
				</div>


				<button type="submit"
					style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Submit</button>

				<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
					Back <a href="viewQueriesTPO.jsp"><font color="white">Click
							Here</font> </a>
				</div>
		</form>
	</div>

</body>
</html>