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
<html lang="en">

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

<style>
.button1 {
  
  border: none;
  color: yellow;
  padding: 5px 20px;
  text-align: left;
  text-decoration: none;
  display: inline-block;
  font-size: 20px;
  margin: 7px 4px;
  cursor: pointer;
}
</style>
<body>



	<h1 style="color: orange; text-shadow: 0.5px 0.5px 0.5px red;">R.
		C. Patel Institute of Technology, Shirpur</h1>
	<div class=" w3l-login-form">
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Ask Queries</h2>
		<form action="AskQuery" method="POST">

			<div class=" w3l-form-group">
				<label>Write a Query:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Type a Query" name="query" required="required" />

				</div>
			</div>


			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Submit</button>

			<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				<a href="menuForStudent.jsp" class="button1">Back To Home Page</a>
			</div>


		</form>
	</div>

</body>
</html>