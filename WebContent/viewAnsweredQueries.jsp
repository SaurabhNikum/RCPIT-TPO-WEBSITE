<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="services.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("viewAnsweredQueries_JSP"); %>
<%
	if (!Auth.getRole(session).equals("STUDENT")) {
		response.sendRedirect("studentLogin.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>RCPIT, TPO</title>
<!-- BOOTSTRAP STYLES-->
<link href="assets/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="assets/css/custom.css" rel="stylesheet" />
<!-- GOOGLE FONTS-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
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
	<%
		//AbstractDao abstractDao=new AbstractDao();
	%>

	<div id="wrapper">

		<%@ include file="studentPageMenu.jsp"%>

		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<h2>&nbsp&nbspQueries of Students</h2>
					<div class="col-md-12">

						<table border="1" id="displaytable" class="table table-bordered"
							style="">
							<thead>
								<tr>
									<th>Roll No</th>
									<th>Name</th>
									<th>Branch</th>
									<th>Query</th>
									<th>Answer</th>


								</tr>
								<%
									Statement statement = null;
									ResultSet resultSet = null;
									try {
										Connection conn = DBconnect.getConnect();
										statement = conn.createStatement();
										String sql = "select * from query";
										resultSet = statement.executeQuery(sql);
										while (resultSet.next()) {
								%>
							
							<tbody>
								<tr>
									<td><%=resultSet.getString("ROLL_NO")%></td>
									<td><%=resultSet.getString("NAME")%></td>
									<td><%=resultSet.getString("BRANCH")%></td>
									<td><%=resultSet.getString("QUERIES")%></td>
									<td><%=resultSet.getString("ANSWER")%></td>


								</tr>
							</tbody>
							<%
								}
									//connection.close();
								} catch (Exception e) {
									log.error("Could not answer query : {}", e);
								}
							%>

							</thead>
						</table>
					</div>
				</div>

			</div>

		</div>
	</div>

	</div>

	<div
		style="color: white; padding: 15px 50px 5px 50px; float: right; font-size: 16px;">
		&nbsp; <a href="menuForAdmin.jsp"
			class="btn btn-danger square-btn-adjust">Back To Home Page</a>
	</div>

	<!-- /. PAGE INNER  -->
	</div>
	<!-- /. PAGE WRAPPER  -->
	</div>
	<!-- /. WRAPPER  -->
	<!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
	<!-- JQUERY SCRIPTS -->
	<script src="assets/js/jquery-1.10.2.js"></script>
	<!-- BOOTSTRAP SCRIPTS -->
	<script src="assets/js/bootstrap.min.js"></script>
	<!-- METISMENU SCRIPTS -->
	<script src="assets/js/jquery.metisMenu.js"></script>
	<!-- CUSTOM SCRIPTS -->
	<script src="assets/js/custom.js"></script>
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
