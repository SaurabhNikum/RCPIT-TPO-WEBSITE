
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="services.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("notifyStudents_JSP"); %>
<%
	if (!Auth.getRole(session).equals("COMPANY")) {
		response.sendRedirect("companyLogin.jsp");
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
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Send
			Notification</h2>
		<form action="SendNotification" method="POST">

			<div class=" w3l-form-group">
				<label>Recepient:</label>
				<div class="group">
					<%
					boolean display1 = false;
					boolean display2 = false;
						try {
							Connection conn = DBconnect.getConnect();
							Statement statement = conn.createStatement();
							String sql = "select * from company where name = '" + session.getAttribute("user").toString() + "'";
							ResultSet resultSet = statement.executeQuery(sql);
							String ssc = "60";
							String hsc = "60";
							String degree = "";
							String backlog="0";					
							String gap="0";
							String eligible_branch="";
						
							if (resultSet.next()) {
								ssc=resultSet.getString("SSC");
								hsc=resultSet.getString("HSC_DIPLOMA");
								degree=resultSet.getString("DEGREE");
								backlog=resultSet.getString("ACTIVE_BACKLOG");
								gap=resultSet.getString("GAP");			
								eligible_branch=resultSet.getString("ELIGIBLE_BRANCH");					
							}
							sql = "select count(ROLL_NO) from student where SSC_MARKS >= '"+
									ssc+"' AND HSC_MARKS >=  '"+hsc+"' AND CGPA >=  '"+degree+"' AND ACTIVE_BACKLOG <="+backlog+" AND GAP<="+gap+" AND BRANCH in ('"+eligible_branch.replaceAll(",", "','")+"')";
									log.info(sql);
									resultSet = statement.executeQuery(sql);
							if (resultSet.next()) {
								display1 = (resultSet.getInt(1)>0)?true:false;
								log.info("count of student is : {}", resultSet.getInt(1));
							}
						if(display1){
					%>
					<label class="radio-inline" style="color: black"><input
						type="radio" class="form-check-input" value="ELIGIBLE" name="to"
						required="required" /><b>ELIGIBLE STUDENTS &nbsp</b></label> <br>
											<%
						}
							sql = "select count(ROLL_NO) from student where SELECTED_IN like '%"
									+ session.getAttribute("user").toString() + "%'";
							resultSet = statement.executeQuery(sql);
							if (resultSet.next()) {
								display2 = (resultSet.getInt(1)>0)?true:false;
								log.info("count of student is : {}", resultSet.getInt(1));
							}
						if(display2){
					%>
					 <label
						class="radio-inline" style="color: black"><input
						type="radio" class="form-check-input" value="PLACED_IN" name="to"
						required="required" /><b>Placed in <%=session.getAttribute("user").toString()%></b></label>

					<%
						}
						if(!(display1||display2))
							out.println("<p>No Eligible or Placed Student in "+ session.getAttribute("user").toString() + " </p>");
						} catch (Exception e) {
							e.printStackTrace();
						}
					%>	
						<input type="text" class="form-check-input"
						value="<%=session.getAttribute("user").toString()%>"
						name="to_company" required="required" style="display: none;" /> <input
						type="text" value="true" name="is_company" required="required"
						style="display: none;" />
				</div>
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

			<% if(display1||display2){ %>
			<button type="submit"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Submit</button>
			<br>
			<%} %>
			<button type="reset"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;">Reset</button>
			<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				<a href="menuForCompany.jsp" class="button1">Back To Home Page</a>
			</div>


		</form>
	</div>

</body>

</html>