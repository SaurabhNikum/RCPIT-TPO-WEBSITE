<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="services.*"%>
<%
	if (!Auth.getRole(session).equals("COMPANY")) {
		if(!Auth.getRole(session).equals("STUDENT")){
			response.sendRedirect("index.jsp");
			return;
		}
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

<script>
function validateEmail(emailField)
{
	var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
    if (reg.test(emailField.value) == false) 
    {
        alert('Invalid Email Address');
        return false;
    }
    return true;
}
</script>
<script type="text/javascript">
   	function access(){
		<% Object s1 = session.getAttribute("msg");
		 if(s1!=null){ %>
		alert('<%=s1.toString()%>');
		<% session.setAttribute("msg",null);
		}	%>
	}
   	
   	function checkPassword(){
   		var password = document.getElementById("password").value;
   		var newpassword = document.getElementById("newpassword").value;
   		var confirmpassword = document.getElementById("confirmpassword").value;
   		if(password==newpassword){
   			alert("Old and New Password should not be same!");
   			return false;
   		}
   		if(newpassword!=confirmpassword){
   			alert("New Password and Confirm Password must be same");
   			return false;
   		}
   		return true;
   	}
</script>
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
<body onload="access()">
	<h1 style="color: orange; text-shadow: 0.5px 0.5px 0.5px red;">R.
		C. Patel Institute of Technology, Shirpur</h1>
	<div class=" w3l-login-form">
		<form action="ChangePassword" method="POST" onsubmit="return checkPassword()">
			<h3 style="color: pink; text-shadow: 0.5px 0.5px 0.5px black;">Change the password</h3>

			<div class=" w3l-form-group">
				<label>Current Password:</label>
				<div class="group">
					<i class="fas fa-unlock"></i> <input type="password" id="password"
						class="form-control" placeholder="Password" name="currentpassword"
						required="required" />
				</div>
			</div>
			
			
			<div class=" w3l-form-group">
				<label>New Password:</label>
				<div class="group">
					<i class="fas fa-unlock"></i> <input type="password" id="newpassword"
						class="form-control" placeholder="Password" name="newpassword"
						required="required" />
				</div>
			</div>
			
			
			
			<div class=" w3l-form-group">
				<label>Confirm Password:</label>
				<div class="group">
					<i class="fas fa-unlock"></i> <input type="password" id="confirmpassword"
						class="form-control" placeholder="Password" name="confirmpassword"
						required="required" />
				</div>
			</div>

			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Submit</button>

			<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				<a href="menuForCompany.jsp" class="button1">Back To Home Page</a>
			</div>



		</form>
	</div>
	<br>
	<br>




	</div>



</body>

</html>