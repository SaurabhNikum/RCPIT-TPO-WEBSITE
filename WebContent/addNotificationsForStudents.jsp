
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="services.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("addNotificationsForStudents_JSP"); %>
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
		<% Object s1 = request.getSession().getAttribute("msg");
		 if(s1!=null){ %>
		alert('<%=s1.toString()%>');
		<% request.getSession().setAttribute("msg",null);
		}	%>
	}
</script>

<script type="text/javascript">
	function checkForm() {
		if (document.getElementById('company_radio').checked) {
			if (document.getElementById('to_company').value == '') {
				alert("Please Select Company First");
				return false;
			}
		}

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
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Send
			Notification</h2>

		<form action="/SendNotification" method="post"
			onsubmit="return checkForm()">

			<div class=" w3l-form-group">
				<label>Recepient:</label>
				<table class="group">
					<tr>
						<td><label class="radio-inline" style="color: black"><input
								type="radio" class="form-check-input" value="ALL" name="to"
								required="required" checked /><b>ALL STUDENTS</b></label></td>
						
						<td><label class="radio-inline" style="color: black;"><input
								type="radio" class="form-check-input" value="PLACED" name="to"
								required="required" /><b>PLACED STUDENTS</b></label></td>
					</tr>
					
					<tr>
						<td><label class="radio-inline" style="color: black"><input
								type="radio" class="form-check-input" value="NON_PLACED"
								name="to" required="required" /><b>NON-PLACED STUDENTS</b></label></td>
						<td><label class="radio-inline" style="color: black"><input
								id="company_radio" type="radio" class="form-check-input"
								value="PLACED_IN" name="to" required="required" /><b>Placed
									in </b> <select name="to_company" id="to_company">
									<option value=''>select company</option>
									<%
										try {
											Connection conn = DBconnect.getConnect();
											Statement statement = conn.createStatement();
											String sql = "select * from company";
											ResultSet resultSet = statement.executeQuery(sql);
											while (resultSet.next()) {
									%>
									<option value="<%=resultSet.getString("NAME")%>"><%=resultSet.getString("NAME")%></option>
									<%
										}
										} 
									catch (Exception e) {
										log.error("Could not add notification : {}", e);
										}
									%>
							</select></label> <input type="text" class="form-check-input"
							value="<%=session.getAttribute("user").toString()%>"
							name="to_company" required="required" style="display: none;" /></td>
					</tr>
				</table>
			</div>

			<div class=" w3l-form-group">
				<label>Subject:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Enter Subject" name="subject" required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>Message:</label>
				<div class="group">
					<i class="fas fa-user"></i>
					<textarea rows="5" cols="100%" name="msg"></textarea>
				</div>
			</div>


			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Submit</button>
			<br>
			<button type="reset"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Reset</button>
			
			<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				<a href="menuForAdmin.jsp" class="button1">Back To Home Page</a>
			</div>



		</form>
	</div>

</body>

</html>