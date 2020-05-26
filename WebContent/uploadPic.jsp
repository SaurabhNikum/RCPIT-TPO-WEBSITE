<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="services.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("uploadPic_JSP"); %>
<%
	if (!Auth.getRole(session).equals("STUDENT")) {
		response.sendRedirect("studentLogin.jsp");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Image</title>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="keywords"
	content="Art Sign Up Form Responsive Widget, Audio and Video players, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, 
		Flat Web Templates, Login Sign-up Responsive Web Template, Smartphone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="assets/css/css.css" rel="stylesheet">
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
		<%
			String fileName = "assets/img/find_user.png";
			Statement statement = null;
			ResultSet rs = null;
			try {
				Connection conn = DBconnect.getConnect();
				statement = conn.createStatement();
				String sql = "select image from student where roll_no = '" + session.getAttribute("ROLL_NO") + "'";
				rs = statement.executeQuery(sql);
				if (rs.next()) {
					fileName = rs.getString("IMAGE");
				}
			} catch (Exception e) {
				log.error("Could not upload pic : {}", e);
			}
			if (!fileName.equalsIgnoreCase("assets/img/find_user.png"))
				fileName = "/Download?file=" + fileName + "&type=image/jpeg";
		%>
		<center>
			<img src="<%=fileName%>" class="img-responsive" width="100px">
		</center>
		<br>
		<h2 style="color: yellow; text-shadow: 0.5px 0.5px 0.5px black;">Upload
			Passport Photo here</h2>
		<form action="UploadImage" method="POST" enctype="multipart/form-data">

			<div class=" w3l-form-group">
				<label>Upload Image</label>
				<div class="group">
					<i class="fas fa-user"></i> <input type="file" class="form-control"
						placeholder="Upload Image" name="filename" required="required"
						size="50" id="image-file" accept="image/*" />
					<script type="text/javascript">
        $('#image-file').bind('change', function() {
            
            if(this.files[0].size/1024/1024>1){
            	alert("File is too Large");
            	$('#image-file').val('');
            }
        });
    </script>

					<!--  <input type="hidden" value=fileNamee name="filename1"/>   -->
				</div>
			</div>



			<button type="submit" value="Upload File"
				style="color: rgb(248, 204, 114); text-shadow: 0.5px 0.5px 0.5px red;"
				onClick="return validate()">Submit</button>

			<div class="col-sm-offset-5 col-sm-10" style="color: yellow;">
				<a href="menuForStudent.jsp" class="button1">Back To Home Page</a>
			</div>


		</form>
	</div>


</body>
</html>