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
<script type="text/javascript">
	function access(){
		<% Object s1 = request.getSession().getAttribute("msg");
		 if(s1!=null){ %>
		alert('<%=s1.toString()%>');
		<% request.getSession().setAttribute("msg",null);
		}	%>
	}
</script>
</head>

<body onload="access()">
	<h1 style="color: orange; text-shadow: 0.5px 0.5px 0.5px red;">R.
		C. Patel Institute of Technology, Shirpur</h1>
	<div class=" w3l-login-form">
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Add
			Company</h2>
		<form action="AddCompany" method="POST">

			<div class=" w3l-form-group">
				<label>Name:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Enter name" name="name" required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>Information:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Add Information" name="information"
						required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>Email ID:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="email" class="form-control"
						placeholder="Enter Email ID" name="email" required="required" />
				</div>
			</div>


			<div class=" w3l-form-group">
				<label>Password:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="password"
						class="form-control" placeholder="Enter Password" name="password"
						required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>Drive Date:</label>
				 <!-- <div class="group">
					<i class="fas fa-user"></i> <input type="date" class="form-control"
						placeholder=" 'YYYY/MM/DD' " name="date" required="required" />
				</div> -->
				
				 <!--    <div class="form-row">
        <input type="date" data-date-size="4" />
    </div> -->
 			<div class="group">
					<i class="fas fa-user"></i> <input type="date" class="form-control"
						placeholder=" 'YYYY/MM/DD' "  name="date" required="required" />
				</div>
				
			</div>

			<div class=" w3l-form-group">
				<label>Drive Location:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Enter Drive Location " name="location"
						required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
			<label>Eligible Branches:</label>
  						<div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Computer">
    						<label >Computer Engineering</label>   							 				 
 						 </div>
 						 
 						 <div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Electrical">
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
				<label>Company Address:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Enter your address" name="address"
						required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>Package:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Enter Package per Annum" name="package"
						required="required" />
				</div>
			</div>


			<div class=" w3l-form-group">
				<label>Contact Number:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="tel" class="form-control"
					onkeypress="return isNumberKey(event)" minlength="10"
						maxlength="10"
						placeholder="Enter contact number" name="mobno"
						required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>CGPA:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						placeholder="Enter CGPA Criteria" name="degree" step ="0.01" min = "1.0" max = "10.0" required="required" />
				</div>
			</div>
			
						<div class=" w3l-form-group">
				<label>HSC/Diploma Marks:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						placeholder="Enter HSC/Diploma Criteria" name="hsc" step ="0.01" min = "35" max = "100" required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>SSC:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						placeholder="Enter SSC Criteria" name="ssc" step ="0.01" min = "35" max = "100" required="required" />
				</div>
			</div>
			
			<div class=" w3l-form-group">
				<label>Active Backlog:</label>
				<div class="group">
 <!-- 					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Branch of Student" name="branch" required="required" />
																							-->			
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
				<label>Gap Till Now:</label>
				<div class="group">
 <!-- 					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Branch of Student" name="branch" required="required" />
																							-->			
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
	

			<div class=" w3l-form-group">
				<label>Selection Process:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Enter selection process" name="selectionprocess"
						required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>Requirement:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Enter requirements of company" name="requirement"
						required="required" />
				</div>
			</div>




			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Submit</button>

	<!--		<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				Home Page <a href="menuForAdmin.jsp"><font color="white">Click
						Here</font> </a>
			</div>  -->
			
			<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				<a href="menuForAdmin.jsp" class="button1">Back To Home Page</a>
			</div>


		</form>
	</div>
    <SCRIPT language=Javascript>
     function isNumberKey(evt)
{
var charCode = (evt.which) ? evt.which : event.keyCode;

if (charCode > 31 && (charCode<48 || charCode>57))
	return false;
	
return true;
}
       
</SCRIPT>
</body>
</head>

</html>