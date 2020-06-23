<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="services.*"%>
<%
	if (!Auth.getRole(session).equals("ADMIN")) {
		response.sendRedirect("adminLogin.jsp");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>


<head>
<title>Admin</title>
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

<script>
	function validateEmail(emailField) {
		var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
		if (reg.test(emailField.value) == false) {
			alert('Invalid Email Address');
			return false;
		}
		return true;
	}
</script>

</head>


<body>
	<h1 style="color: orange; text-shadow: 0.5px 0.5px 0.5px red;">R.
		C. Patel Institute of Technology, Shirpur</h1>

	<br>
	<br>
	<div class=" w3l-login-form">
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Welcome
			Admin</h2>
		<form action="addCompany.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Add
				Company</button>
		</form>
		<br>
		<br>
		<br>


		<form action="addNotificationsForStudents.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Add
				Notification for Students</button>
		</form>
		<br>
		<br>
		<br>
		
		<form action="password1.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Change
				 Company Password</button>
		</form>
		<br>
		<br>
		<br>		

		<form action="viewStudentTPO.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">View
				Students</button>
		</form>
		<br>
		<br>
		<br>

		<form action="viewStudentAcademicTPO.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">View
				Students (Academic + Address)</button>
		</form>
		<br>
		<br>
		<br>

		<form action="addCompanyToStudentProfile.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Add
				Company To Student Profile</button>
		</form>
		<br>
		<br>
		<br>

		<form action="sortStudents.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Sort
				Students</button>
		</form>
		<br>
		<br>
		<br>

		<form action="viewCompanyTPO.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">View
				Company</button>
		</form>
		<br>
		<br>
		<br>
		<form action="viewPlacementsTillDate.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">View
				Placements till date</button>
		</form>
		<br>
		<br>
		<br>



		<form action="viewQueriesTPO.jsp">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">View
				Queries</button>
		</form>
		<br>
		<br>
		<br>
		<form action="/Logout">
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Logout</button>
		</form>
		<br>
		<br>
		<br>


	</div>



</body>
</html>