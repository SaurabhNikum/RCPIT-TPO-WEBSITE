<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%><%@page import="services.*"%>
<%
if (!Auth.getRole(session).equals("ADMIN")) {
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
	<h1 style="color: orange; text-shadow: 0.5px 0.5px 0.5px red;">R.C. Patel Institute of Technology, Shirpur</h1>

	<br>
	<br>
	<div class=" w3l-login-form">
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Welcome
			Milkesh Jain Sir</h2>
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Sort The Students</h2>

		<form action="SortStudents" method="post">
		
			<div class=" w3l-form-group">
			<label>Eligible Branches:</label>
  						<div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Computer">
    						<label >Computer Engineering</label>   							 				 
 						 </div>
 						 
 						 <div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Electronics">
    						<label >Electrical Engineering</label>   							 				 
 						 </div>
 						 
 						 <div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Mechanical">
    						<label >Mechanical Engineering</label>   							 				 
 						 </div>
 						 
 						  <div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Civil">
    						<label >Civil Engineering</label>   							 				 
 						 </div>
 						 
 						 <div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Electronics and telecommunication">
    						<label >ENTC Engineering</label>   							 				 
 						 </div>

			</div>		
		
			<div class=" w3l-form-group">
				<label>SSC Marks:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						placeholder="Criteria SSC" name="ssc" step ="0.01" min = "35" max = "100"
						required="required" />

				</div>
			</div>
			<div class=" w3l-form-group">
				<label>HSC Marks:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						placeholder="Criteria HSC" name="hsc" step ="0.01" min = "35" max = "100"
						required="required" />

				</div>
			</div>
			<div class=" w3l-form-group">
				<label>CGPA:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						placeholder="Criteria CGPA" name="cgpa" step ="0.01" min = "1.0" max = "10.0" required="required" />

				</div>
			</div>
			
		<div class=" w3l-form-group">
				<label>Active Backlog:</label>
				<div class="group">
 <!-- 					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Number of active backlog" name="activebacklog"
						required="required" />                    	-->	
								<i class="fas fa-user"></i>				
<select id="div" name="activebacklog">
<option value="">select no of backlog</option>
  <option value="0">0</option>
  <option value="1">1</option>
  <option value="2">2</option>
  <option value="3">3</option>
  <option value="4">4</option>
  <option value="5">5</option>
</select>
				</div>
			</div>				
		<div class=" w3l-form-group">
				<label>Year Gap:</label>
				<div class="group">
 <!-- 					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Number of active backlog" name="activebacklog"
						required="required" />                    	-->	
								<i class="fas fa-user"></i>				
<select id="div" name="gap">
<option value="">select year gap</option>
  <option value="0">0</option>
  <option value="1">1</option>
  <option value="2">2</option>
  <option value="3">3</option>
  <option value="4">4</option>
  <option value="5">5</option>
</select>
				</div>
			</div>				
			
			<button type="submit" value="Submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Submit</button>
			<br>
			<br>
			<form action="menuForAdmin.jsp">
			<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				<a href="menuForAdmin.jsp" class="button1">Back To Home Page</a>
			</div>
			</form>
			<br>
			<br>
			<br>
		</form>
		
		
	</div>



</body>
</html>