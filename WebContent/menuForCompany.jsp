<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="services.*"%>
<%
	if (!Auth.getRole(session).equals("COMPANY")) {
		response.sendRedirect("companyLogin.jsp");
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
	<h1 style="color: orange; text-shadow: 0.5px 0.5px 0.5px red;">R. C. Patel Institute of Technology, Shirpur</h1>

	<div class=" w3l-login-form">

		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">We Welcome
				You to RCPIT</h2>
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Welcome <%= session.getAttribute("user") %></h2>				
		<form action="updateDriveDetails.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Update
				Information</button>
		</form>
		<br>
		<br>

		<form action="addCompanyToStudentProfile.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Add Company to Student Profile</button>
		</form>
		<br>
		<br>

		<form action="viewStudentCompany.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">View
				Students</button>
		</form>
		<br>
		<br>


		<form action="sharedFiles.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Share The Files</button>
		</form>
		<br>
		<br>

		<form action="notifyStudents.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Send Notification to Students</button>
		</form>
		<br>
		<br>

		<form action="password.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Change Password</button>
		</form>
		<br>
		<br>

		<form action="/Logout">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Logout</button>
		</form>

	</div>