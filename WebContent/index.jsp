<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="services.*"%>
<%
	if (Auth.isValidUser(session)) {
		if (Auth.getRole(session).equals("ADMIN"))
			response.sendRedirect("menuForAdmin.jsp");
		if (Auth.getRole(session).equals("COMPANY"))
			response.sendRedirect("menuForCompany.jsp");
		if (Auth.getRole(session).equals("STUDENT"))
			response.sendRedirect("menuForStudent.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
	<center></center>
	<div class="col-md-12">
		<div style="width: 50%; float: left">
		<br><br>
			<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px red;">
				<b>Project By 2019-20 Batch Students</b><br><b>Branch: Computer Enginering</b><br><br>Saurabh Nikum<br>Shweta Mahajan<br>Rohit Narkhede<br> Kalyani
				Mahajan<br>
				
			</h2>
		</div>
		<div style="width: 50%; float: right">
			<div class=" w3l-login-form">
				<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Login
					Here</h2>

				<form action="adminLogin.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">TPO
						Login</button>
				</form>
				<br> <br> <br>
				<form action="companyLogin.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Company
						Login</button>
				</form>
				<br> <br> <br>
				<form action="studentLogin.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Student
						Login</button>
				</form>
				<br> <br> <br>
				<form action="guestLogin.jsp">
					<button type="submit"
						style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Guest
						Login</button>
				</form>
			</div>
		</div>
	</div>
	<SCRIPT language=Javascript>
		function isNumberKey(evt) {
			var charCode = (evt.which) ? evt.which : event.keyCode;

			if (charCode > 31 && (charCode<48 || charCode>57))
				return false;

			return true;
		}
	</SCRIPT>

</body>






</head>

</html>