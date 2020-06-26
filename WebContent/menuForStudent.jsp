<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="services.*"%>
<%
	if (!Auth.getRole(session).equals("STUDENT")) {
		response.sendRedirect("studentLogin.jsp");
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
	<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Welcome <%= session.getAttribute("name") %></h2>		

	<br>
	<br>
<div class="col-md-12">	
		<div style="width: 50%; float: left">	
			<div class=" w3l-login-form">
		
				<form action="uploadResume.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Upload/Update
						Resume</button>
				</form>
				<br>
				<br>

		
				<form action="uploadPic.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Upload/Update
						Passport photo</button>
				</form>
				<br>
				<br>

				
				<form action="editProfile.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Edit Personal Information</button>
				</form>
				<br>
				<br>
		
				
				<form action="viewDrives.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">View Upcoming
						Campus Drives Details</button>
				</form>
				<br>
				<br>

				<form action="viewSelectionProcess.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">View
						Selection Process Of Company</button>
				</form>
				<br>
				<br>
			
				<form action="learnAptituteQuestions.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Learn
						Aptitute Questions</button>
				</form>
			</div>
		</div>
		<div style="width: 50%; float: left">	
			<div class=" w3l-login-form">	
				<form action="https://accounts.google.com/">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">View
						Notifications</button>
				</form>
				<br>
				<br>

		
				<form action="askQueries.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Ask
						Queries</button>
				</form>
				<br>
				<br>

				<form action="addFeedback.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Add
						Feedback For Students</button>
				</form>
				<br>
				<br>

				<form action="viewAnsweredQueries.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">View
						Answered Queries By TPO</button>
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
		</div>

</div>


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