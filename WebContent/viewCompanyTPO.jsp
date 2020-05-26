<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="services.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("viewCompanyTPO_JSP"); %>
<%
	if (!Auth.getRole(session).equals("ADMIN")) {
		response.sendRedirect("adminLogin.jsp");
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

		<%@ include file="adminPageMenu.jsp"%>

		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<h2>&nbsp&nbspView Company</h2>
					<div class="col-md-12">
						<span><a href="/DownloadExcel1"><button class="btn btn-primary square-btn-adjust" style="float: right; margin-bottom: 10px;">Download in Excel</button></a></span>

						<table border="1" id="displaytable" class="table table-bordered"
							style="">
							<thead>
								<tr>
									<th>Name</th>
									<th>Information</th>
									<th>Email ID</th>
									<th>Drive Date</th>
									<th>Drive Location</th>
									<th>Package</th>
									<th>CGPA</th>
									<th>HSC / Diploma</th>
									<th>SSC</th>
									<th>ACTIVE BACKLOG</th>			
									<th>GAP</th>																
									<th>Selection Process</th>
									<th>Requirements</th>
									<th>Address</th>
									<th>Contact No</th>
									<th>Attached File</th>
									<th>Eligible Branches</th>

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
										String sql = "select * from company";
										resultSet = statement.executeQuery(sql);
										while (resultSet.next()) {
								%>
							
							<tbody>
								<tr>
									<td><%=resultSet.getString("NAME")%></td>
									<td><%=resultSet.getString("INFORMATION")%></td>
									<td><%=resultSet.getString("EMAIL_ID")%></td>
									<td><%=resultSet.getString("DRIVE_DATE")%></td>
									<td><%=resultSet.getString("DRIVE_LOCATION")%></td>
									<td><%=resultSet.getString("PACKAGE")%></td>

									<td><%=resultSet.getString("DEGREE")%></td>
									<td><%=resultSet.getString("HSC_DIPLOMA")%></td>
									<td><%=resultSet.getString("SSC")%></td>
									<td><%=resultSet.getString("ACTIVE_BACKLOG")%></td>				
									<td><%=resultSet.getString("GAP")%></td>															
									<td><%=resultSet.getString("SELECTION_PROCESS")%></td>
									<td><%=resultSet.getString("REQUIREMENT")%></td>
									<td><%=resultSet.getString("ADDRESS")%></td>
									<td><%=resultSet.getString("CONTACT_NUMBER")%></td>

									<td>
										<%

											Statement stmt = conn.createStatement();
											String sql1 = "select * from file where company_id = "+ resultSet.getString("company_id");
											ResultSet rs = stmt.executeQuery(sql1);
											if (rs.next()) {
												out.print("<a href='sharedFiles.jsp?company_id="+resultSet.getString("company_id")+"'>View</a>");
											}
											rs.close();stmt.close();
										%>
									</td>
									<td><%=resultSet.getString("ELIGIBLE_BRANCH")%></td>									

								</tr>
							</tbody>
							<%
								}
									//connection.close();
								} catch (Exception e) {
									log.error("Could not view company : {}", e);
								}
							%>

						</table>
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
	<script type="text/javascript">
		$(".image_view")
				.click(
						function() {
							var name = $(this).data('name');
							$("#modal_name").html("NAME:- " + name);
							var imgUrl = $(this).data('rel');
							$("#area")
									.html(
											"<img src='"
													+ imgUrl
													+ "' alt='Large Profile Pic' width='50%''' />");
							$("#download_button")
									.html(
											"<a href='"+imgUrl+"'><button type='button' class='btn btn-primary'>Download</button></a>");
						});
	</script>
	
	<script src="assets/js/custom.js"></script>
	<SCRIPT type="text/javascript">
		function isNumberKey(evt) {
			var charCode = (evt.which) ? evt.which : event.keyCode;

			if (charCode > 31 && (charCode<48 || charCode>57))
				return false;

			return true;
		}
	</SCRIPT>

</body>
</html>
