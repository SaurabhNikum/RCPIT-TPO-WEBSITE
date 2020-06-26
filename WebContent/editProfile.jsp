<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="services.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("editProfile_JSP"); %>
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
		<% Object s1 = session.getAttribute("msg");
		 if(s1!=null){ %>
		alert('<%=s1.toString()%>');
		<% session.setAttribute("msg",null);
		}	%>
	}
</script>
</head>
<body onload="access()">
	<h1 style="color: orange; text-shadow: 0.5px 0.5px 0.5px red;">R.
		C. Patel Institute of Technology, Shirpur</h1>
	<div class=" w3l-login-form">
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Update
			Profile</h2>
		<%
			try {
				Connection conn = DBconnect.getConnect();
				PreparedStatement ps = conn.prepareStatement("select * from student where student_id=?");
				ps.setString(1, session.getAttribute("user_id").toString());
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
		%>
		<form action="EditProfile" method="POST">

			<div class=" w3l-form-group">
				<label>Name:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						value="<%=rs.getString("NAME")%>"
						placeholder="Enter your full name" name="name" required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>Roll Number:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number"
						value="<%=rs.getString("ROLL_NO")%>" class="form-control"
						placeholder="Enter roll number of student" name="rollno"
						min="1" max="500" required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>Branch:</label>
				<div class="group">
					<!-- 					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Branch of Student" name="branch" required="required" />
																							-->
					<i class="fas fa-user"></i> <select id="branch" name="branch">
						<option value="">select branch</option>
						<%
							String branch = rs.getString("BRANCH");
						%>
						<option value="Civil" <%=branch.equals("Civil") ? "selected" : ""%>>Civil
							Engineering</option>
						<option value="Computer"
							<%=branch.equals("Computer") ? "selected" : ""%>>Computer
							Engineering</option>
						<option value="Electronics"
							<%=branch.equals("Electronics") ? "selected" : ""%>>Electrical
							Engineering</option>
						<option value="Electronics and telecommunication"
							<%=branch.equals("Electronics and telecommunication") ? "selected" : ""%>>Electronics
							and telecommunication Engineering</option>
						<option value="Mechanical"
							<%=branch.equals("Mechanical") ? "selected" : ""%>>Mechanical
							Engineering</option>
					</select>

				</div>
			</div>


			<!--		<div class=" w3l-form-group">
				<label>Division:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Enter division" name="div" required="required" />
				</div>
			</div>  -->

			<div class=" w3l-form-group">
				<label>Division:</label>
				<div class="group">
					<!-- 					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Branch of Student" name="branch" required="required" />
																							-->
					<i class="fas fa-user"></i> <select id="div" name="div">
						<option value="">select division</option>
						<%
							String div = rs.getString("DIV");
						%>
						<option value="A" <%=div.equals("A") ? "selected" : ""%>>A</option>
						<option value="B" <%=div.equals("B") ? "selected" : ""%>>B</option>
						<option value="C" <%=div.equals("C") ? "selected" : ""%>>C</option>
						<option value="D" <%=div.equals("D") ? "selected" : ""%>>D</option>

					</select>

				</div>
			</div>




			<div class=" w3l-form-group">
				<label>Email:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="email"
						value="<%=rs.getString("EMAIL_ID")%>" class="form-control"
						placeholder="Enter Email" name="email" required="required" />
				</div>
			</div>


			<!--			<div class=" w3l-form-group">
				<label>Mobile Number:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Enter mobile number" name="mobno" required="required" />
				</div>
			</div>
															-->

 			<div class=" w3l-form-group">
				<label>Contact Number:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="tel" class="form-control"
					   value="<%=rs.getString("MOBILE_NO")%>" 
					    onkeypress="return isNumberKey(event)" minlength="10"
						maxlength="10"
						placeholder="Enter contact number" name="mobno"
						required="required" />
				</div>
			</div>


			<div class=" w3l-form-group">
				<label>Address:</label>
				<div class="group">
					<i class="fas fa-user"></i>
					<textarea class="form-control" placeholder="Enter your address"
						name="address" rows="5" cols="100%" required="required"><%=rs.getString("ADDRESS")%></textarea>
				</div>
			</div>


			<div class=" w3l-form-group">
				<label>CGPA:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						value="<%=rs.getString("CGPA")%>" placeholder="Enter CGPA"
						name="cgpa" step ="0.01" min = "1.0" max = "10.0" required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>Active Backlog:</label>
				<div class="group">
				
				
					<i class="fas fa-user"></i> <select id="back" name="activebacklog">
						<option value="">select no of backlog</option>
						<%
							String back = rs.getString("ACTIVE_BACKLOG");
						%>
						<option value="0" <%=back.equals("0") ? "selected" : ""%>>0</option>
						<option value="1" <%=back.equals("1") ? "selected" : ""%>>1</option>
						<option value="2" <%=back.equals("2") ? "selected" : ""%>>2</option>
						<option value="3" <%=back.equals("3") ? "selected" : ""%>>3</option>
						<option value="4" <%=back.equals("4") ? "selected" : ""%>>4</option>
						<option value="5" <%=back.equals("5") ? "selected" : ""%>>5</option>

					</select>				
					
				</div>
			</div>
			
			<div class=" w3l-form-group">
				<label>Year Gap:</label>
				<div class="group">
				
				
					<i class="fas fa-user"></i> <select id="back1" name="gap">
						<option value="">select no of backlog</option>
						<%
							String back1 = rs.getString("GAP");
						%>
						<option value="0" <%=back1.equals("0") ? "selected" : ""%>>0</option>
						<option value="1" <%=back1.equals("1") ? "selected" : ""%>>1</option>
						<option value="2" <%=back1.equals("2") ? "selected" : ""%>>2</option>
						<option value="3" <%=back1.equals("3") ? "selected" : ""%>>3</option>
						<option value="4" <%=back1.equals("4") ? "selected" : ""%>>4</option>
						<option value="5" <%=back1.equals("5") ? "selected" : ""%>>5</option>
					</select>				
					
				</div>
			</div>			
			

			<div class=" w3l-form-group">
				<label>SSC Marks:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						value="<%=rs.getString("SSC_MARKS")%>"
						placeholder="Enter SSC Marks" name="ssc" step ="0.01" min = "35" max = "100" required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
				<label>HSC Marks / Diploma Marks:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						value="<%=rs.getString("HSC_MARKS")%>"
						placeholder="Enter HSC Marks" name="hsc" step ="0.01" min = "35" max = "100"required="required" />
				</div>
			</div>


			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Submit</button>

			<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				<a href="studentLogin.jsp" class="button1">Back To Home Page</a>
			</div>


		</form>
		<%
			}
			} catch (Exception e) {
				log.error("Could not edit profile : {}", e);
			}
		%>
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

</html>