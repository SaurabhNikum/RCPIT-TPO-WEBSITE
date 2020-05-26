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
<link
	href="//fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<style>
body {
	background-image: url('images/cover4.jpg');
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-size: cover;
}
</style>

<style>
.button {
	background-color: #DC143C;
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}
</style>

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

	<br>
	<br>
	<div class=" w3l-login-form">

		<h2 style="color: black; text-shadow: 0.5px 0.5px 0.5px black;">Welcome
			Students</h2>

		<table style="width: 100%">
			<tr>
				<td>
					<form action="https://www.faceprep.in/tcs/tcs-aptitude-questions/">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">TCS</button>
					</form> <br> <br> <br>
				</td>

				<td><form
						action="https://www.faceprep.in/cognizant-aptitude-questions/">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Cognizant</button>
					</form> <br> <br> <br></td>

				<td><form
						action="http://placement.freshersworld.com/persistent-placement-papers/aptitude-general/33131128">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Persistant</button>
					</form> <br> <br> <br></td>
				<td><form
						action="https://www.faceprep.in/wipro/wipro-aptitude-questions/">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Wipro</button>
					</form> <br> <br> <br></td>
			</tr>
			<tr>
				<td>
					<form action="https://www.faceprep.in/kpit-placement-papers/">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">KPIT</button>
					</form> <br> <br> <br>
				</td>
				<td>
					<form
						action="https://www.glassdoor.co.in/Interview/Systenics-Solutions-Interview-Questions-E491130.htm">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Systenics</button>
					</form> <br> <br> <br>
				</td>
				<td>
					<form
						action="https://www.glassdoor.co.in/profile/joinNow_input.htm?hs=true&uoh=10&requestUrl=%2FInterview%2FClover-Infotech-Interview-Questions-E323509.htm">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Clover</button>
					</form> <br> <br> <br>
				</td>

				<td><form
						action="https://www.faceprep.in/tech-mahindra-aptitude/">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Tech
							Mahindra</button>
					</form> <br> <br> <br></td>
			</tr>
			<tr>
				<td>
					<form
						action="https://www.glassdoor.co.in/profile/joinNow_input.htm?hs=true&uoh=10&requestUrl=%2FInterview%2FEternus-Solutions-Interview-Questions-E779949.htm">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Eternus</button>
					</form> <br> <br> <br>
				</td>

				<td><form action="https://www.geeksforgeeks.org/tag/xoriant/">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Xoriant</button>
					</form> <br> <br> <br></td>

				<td>
					<form
						action="https://www.faceprep.in/accenture-aptitude-questions/">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Accenture</button>
					</form> <br> <br> <br>
				</td>
				<td>
					<form
						action="https://www.glassdoor.co.in/profile/joinNow_input.htm?hs=true&uoh=10&requestUrl=%2FInterview%2FCoditas-Interview-Questions-E1192786.htm">
						<button class="button" type="submit"
							style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Coditas</button>
					</form> <br> <br> <br>
				</td>
			</tr>
		</table>

			<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				<a href="menuForStudent.jsp" class="button1">Back To Home Page</a>
			</div>
	</div>
</body>
</html>

