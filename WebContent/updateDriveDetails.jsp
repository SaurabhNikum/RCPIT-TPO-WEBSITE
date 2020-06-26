<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="services.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("updateDriveDetails_JSP"); %>
<%
	if (!Auth.getRole(session).equals("COMPANY")) {
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
<script type="text/javascript">
	function access(){
		<% Object s1 = session.getAttribute("msg");
		 if(s1!=null){ %>
		alert('<%=s1.toString()%>');
		<% session.setAttribute("msg",null);
		}	%>
	}
</script>

<body onload="access()">
	<h1 style="color: orange; text-shadow: 0.5px 0.5px 0.5px red;">R.
		C. Patel Institute of Technology, Shirpur</h1>
	<div class=" w3l-login-form">
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Update <%= session.getAttribute("user") %> Drive Details</h2>
		
		<%
		try {
			Connection conn = DBconnect.getConnect();
			PreparedStatement ps = conn.prepareStatement("select * from company where company_id=?");
			ps.setString(1, session.getAttribute("user_id").toString());
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
	%>
		
		<form action="UpdateDriveDetails" method="POST">
			<div class=" w3l-form-group">
				<label>Email</label>

				 			<div class="group">
					<i class="fas fa-user"></i> <input type="email" class="form-control"
						value="<%=rs.getString("EMAIL_ID")%>"

						placeholder=" Enter New Information "  name="email_id" required="required" />
				</div>
				
			</div>		
			<div class=" w3l-form-group">
				<label>Information:</label>

				 			<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						value="<%=rs.getString("INFORMATION")%>"

						placeholder=" Enter New Information "  name="info" required="required" />
				</div>
				
			</div>
		
			<div class=" w3l-form-group">
				<label>Drive Date:</label>

				 			<div class="group">
					<i class="fas fa-user"></i> <input type="date" class="form-control"
						value="<%=rs.getString("DRIVE_DATE")%>"

						placeholder=" 'YYYY/MM/DD' "  name="date" required="required" />
				</div>
				
			</div>

			<div class=" w3l-form-group">
				<label>Drive Location:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						value="<%=rs.getString("DRIVE_LOCATION")%>"
					
						placeholder="Drive New Location" name="location" required="required" />
				</div>
			</div>

			<div class=" w3l-form-group">
			<label>Eligible Branches:</label>
  						<div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Computer" <% if(rs.getString("ELIGIBLE_BRANCH").contains("Computer")){ %>checked<%}%>>
    						<label >Computer Engineering</label>   							 				 
 						 </div>
 						 
 						 <div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Electronics" <% if(rs.getString("ELIGIBLE_BRANCH").contains("Electronics")){ %>checked<%}%>>
    						<label >Electrical Engineering</label>   							 				 
 						 </div>
 						 
 						 <div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Mechanical" <% if(rs.getString("ELIGIBLE_BRANCH").contains("Mechanical")){ %>checked<%}%>>
    						<label >Mechanical Engineering</label>   							 				 
 						 </div>
 						 
 						  						  						 <div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Civil" <% if(rs.getString("ELIGIBLE_BRANCH").contains("Civil")){ %>checked<%}%>>
    						<label >Civil Engineering</label>   							 				 
 						 </div>
 						 
 						 <div class="group">
    						<i class="fas fa-user"></i>
    						<input type="checkbox" name="eligible" value="Electronics and telecommunication" <% if(rs.getString("ELIGIBLE_BRANCH").contains("Electronics and telecommunication")){ %>checked<%}%>>
    						<label >ENTC Engineering</label>   							 				 
 						 </div>

			</div>

			
			<div class=" w3l-form-group">
				<label>SSC Marks:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						value="<%=rs.getString("SSC")%>"
						
					placeholder="Enter Criteria for SSC" name="ssc" step ="0.01" min = "35" max = "100"required="required" />
				</div>
			</div>
			
			<div class=" w3l-form-group">
				<label>HSC Marks:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						value="<%=rs.getString("HSC_DIPLOMA")%>"

						placeholder="Enter Criteria for HSC/Diploma" name="hsc" step ="0.01" min = "35" max = "100" required="required" />
				</div>
			</div>
			
			<div class=" w3l-form-group">
				<label>CGPA:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="number" class="form-control"
						value="<%=rs.getString("DEGREE")%>"

						placeholder="Enter Criteria for CGPA" name="cgpa" step ="0.01" min = "1.0" max = "10.0" required="required" />
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
						<option value="">select year gap</option>
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
				<label>Package:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						value="<%=rs.getString("PACKAGE")%>"

						placeholder="Enter Package Offered" name="package" required="required" />
				</div>
			</div>
			
			<div class=" w3l-form-group">
				<label>Selection Process:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						value="<%=rs.getString("SELECTION_PROCESS")%>"

						placeholder="Enter Selection Process" name="process" required="required" />
				</div>
			</div>
			
			
				<div class=" w3l-form-group">
				<label>Requirements:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						value="<%=rs.getString("REQUIREMENT")%>"

						placeholder="Enter Requirements" name="process" required="required" />
				</div>
			</div>

				<div class=" w3l-form-group">
				<label>Contact:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="tel" class="form-control"
						value="<%=rs.getString("CONTACT_NUMBER")%>"
						onkeypress="return isNumberKey(event)" minlength="10"
						maxlength="10" placeholder="Enter New Contact Number" name="contact" required="required" />
				</div>
			</div>
						
				<div class=" w3l-form-group">
				<label>Address:</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						value="<%=rs.getString("ADDRESS")%>"

						placeholder="Enter New Address" name="address" required="required" />
				</div>
			</div>						
			


			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Update</button>

			<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				<a href="menuForCompany.jsp" class="button1">Back To Home Page</a>
			</div>


		</form>
		<%
			}
			} catch (Exception e) {
				log.error("Could not update the drive details : {}", e);
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