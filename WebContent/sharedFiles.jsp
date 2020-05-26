<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="services.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("sharedFiles_JSP"); %>
<%
	if (!Auth.isValidUser(session)) {
		response.sendRedirect("index.jsp");
		return;
	}
	String share_id = request.getParameter("company_id");

	if(Auth.getRole(session).equals("COMPANY")){
		share_id = session.getAttribute("user_id").toString();
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
		<%
			if(Auth.getRole(session).equals("COMPANY")){
		%>
		<%@ include file="companyPageMenu.jsp"%>
		<%
			}else if(Auth.getRole(session).equals("STUDENT")){
		%>
		<%@ include file="studentPageMenu.jsp"%>
		<%
			}else{
		%>
		<%@ include file="adminPageMenu.jsp"%>
		<%
			}
		%>
		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
				<%
					if(Auth.getRole(session).equals("COMPANY")){
				%>
					<div class="col-md-12 navbar" >

						<form action="SharedFiles" method="POST" enctype="multipart/form-data">
							<div class="col-md-4" >
								<input type="file" name="filename" class="form-control" re/>
							</div>
							<div class="col-md-4">
								<input type="text" name="description" placeholder="File Description..." class="form-control" required="required"/>
							</div>
							<div class="col-md-4">
								<input type="submit" value="Add File" class="btn btn-primary square-btn-adjust" class="form-control" />
							</div>
						</form>
					</div>
					
				<% } %>
					
					<h2>&nbsp&nbspFiles</h2>
						<table border="1" id="displaytable" class="table table-bordered"
							style="">
							<thead>
								<tr>
									<th>Name</th>
									<th>Download</th> 
								<% if(Auth.getRole(session).equals("COMPANY")){ %>
									<th>Delete</th>
								<% } %>	

								</tr>
							</thead>
							<%
								Statement statement = null;
								ResultSet resultSet = null;
							%>
							<%
								try {
									Connection conn = DBconnect.getConnect();
									statement = conn.createStatement();
									String sql = "select * from file where company_id = "+share_id;
									resultSet = statement.executeQuery(sql);
									while (resultSet.next()) {
							%>

							<tbody>
								<tr>
									<td><%=resultSet.getString("description")%></td>
									<td><a href="Download?file=<%=resultSet.getString("file")%>&type=<%=resultSet.getString("type")%>"><i class="fa fa-download" style="font-size: 150%; cursor: pointer;"></i></a></td>
								<% if(Auth.getRole(session).equals("COMPANY")){ %>
									<td><a href="SharedFiles?delete_file_id=<%=resultSet.getString("file_id")%>"><i class="fa fa-trash-o" style="font-size: 150%; color: red; cursor: pointer;"></i></a></td> 
								<% } %>	
								</tr>
							</tbody>
							<%
								}
									//connection.close();
								} catch (Exception e) {
									log.error("Could not share file : {}", e);
								}
							%>
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

	<script src="assets/js/custom.js"></script>

</body>
</html>
