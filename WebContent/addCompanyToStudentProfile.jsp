<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="services.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("addCompanyToStudentProfile_JSP"); %>
<%
	if (!Auth.getRole(session).equals("COMPANY")) {
		if(!Auth.getRole(session).equals("ADMIN")){
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
			Student Profile</h2>
		<form action="AddCompanyToStudentProfile" method="POST">

		<div class=" w3l-form-group">
				<label>Roll Number:</label>
				<div class="group">
					<i class="fas fa-user"></i> <textarea class="form-control" placeholder="Enter roll number separated by comma (,)" rows="5" cols="100%"
						name="rollno" required="required"><%=session.getAttribute("rolls")!=null?session.getAttribute("rolls"):"" %></textarea>
				</div>
			</div>
			
			

			<div class=" w3l-form-group">
				<label>Branch:</label>
				<div class="group">
					<!-- 					<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Branch of Student" name="branch" required="required" />
																							-->
					<i class="fas fa-user"></i> <select id="branch" name="branch" required="required">
						<option value="">select branch</option>
						<% String branch = session.getAttribute("branch")!=null?session.getAttribute("branch").toString():""; %>
						<option value="Civil" <%=branch.equals("Civil")? "selected":"" %>>Civil Engineering</option>
						<option value="Computer" <%=branch.equals("Computer")? "selected":"" %>>Computer Engineering</option>
						<option value="Electronics" <%=branch.equals("Electronics")? "selected":"" %>>Electronics Engineering</option>
						<option value="Electronics and telecommunication" <%=branch.equals("Electronics and telecommunication")? "selected":"" %>>Electronics
							and telecommunication Engineering</option>
						<option value="Mechanical" <%=branch.equals("Mechanical")? "selected":"" %>>Mechanical Engineering</option>
					</select>

				</div>
			</div>

			<div class=" w3l-form-group">
				<label>Company</label>
				<div class="group">
					<i class="fas fa-user"></i> <label class="radio-inline"
						style="color: black">
						<% if(Auth.getRole(session).equals("COMPANY")){ %>
							<input type="text" class="form-control" name="cname" value="<%= session.getAttribute("user") %>" required="required" readonly/>
						<% }else{ %>
						<select name="cname" id="to_company">
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
								} catch (Exception e) {
									log.error("Could not load companies : {}", e);
								}
							%>
					</select>
					<% } %>
				</div>

				<!-- 				<div class="group">
			<i class="fas fa-user"></i> 
                   <input type="text" class="form-control"
						placeholder="Company Name to be Added" name="cname"
						required="required" />
																		
			</div> 	                 -->

			</div>

			<div class=" w3l-form-group">
				<label>Package:</label>
				<div class="group">
					<% if(!Auth.getRole(session).equals("COMPANY")){ %>
						<i class="fas fa-user"></i> <input type="text" class="form-control"
						placeholder="Package Offered Per Annum" name="package"
						required="required" />
					<% }else{ %>
						<%
							try {
								Connection conn = DBconnect.getConnect();
								Statement statement = conn.createStatement();
								String sql = "select * from company where name='"+session.getAttribute("user")+"'";
								ResultSet resultSet = statement.executeQuery(sql);
								if (resultSet.next()) {
						%>
							<i class="fas fa-user"></i> <input type="text" class="form-control" value="<%=resultSet.getString("package")%>" name="package" required="required" readonly/>
						<%
							}
							} catch (Exception e) {
								log.error("Could not load company : {}", e);
							}
						%>
					<% } %>
					
					
				</div>
			</div>

			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Update</button>

			<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				<a href="menuForCompany.jsp" class="button1">Back To Home Page</a>
			</div>


		</form>
	</div>


</body>
</html>