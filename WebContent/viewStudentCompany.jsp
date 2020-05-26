<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="services.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("viewStudentCompany_JSP"); %>
<%
	if (!Auth.getRole(session).equals("COMPANY")) {
		response.sendRedirect("companyLogin.jsp");
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
	
		<%@ include file="companyPageMenu.jsp"%>

		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<h2>&nbsp&nbspView Students</h2>
					<div class="col-md-12">
						<span><a href="/DownloadExcel"><button class="btn btn-primary square-btn-adjust" style="float: right; margin-bottom: 10px;">Download in Excel</button></a></span>
						<table border="1" id="displaytable" class="table table-bordered"
							style="">
							<thead>
								<tr>
									<th>Name</th>
									<th>Branch</th>
									<th>Roll no</th>
									<th>Email ID</th>
									<th>Mobile Number</th>
									<th>CGPA</th>
									<th>SSC Marks</th>
									<th>HSC Marks</th>
									<th>Active Backlog</th>
									<th>GAP</th>									
									<th>Address</th>
									<th>Photo</th>
									<th>Resume</th>


								</tr>
								<%
									Statement statement = null;
									ResultSet resultSet = null;
								%>
								<%
									try {
										Connection conn = DBconnect.getConnect();
										statement = conn.createStatement();
										String sql = "select * from company where name = '" + session.getAttribute("user") + "'";
										resultSet = statement.executeQuery(sql);
										String ssc = "50";
										String hsc = "50";
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
										log.info(ssc);log.info(hsc);log.info(degree);log.info(backlog);log.info(gap);										
										sql = "select * from student where SELECTED_IN like '%"+session.getAttribute("user")+"%' UNION  select * from student where SSC_MARKS >= '"+
												ssc+"' AND HSC_MARKS >=  '"+hsc+"' AND CGPA >=  '"+degree+"' AND ACTIVE_BACKLOG <="+backlog+" AND GAP<="+gap+" AND BRANCH in ('"+eligible_branch.replaceAll(",", "','")+"') AND SELECTED_IN is null";
										resultSet = statement.executeQuery(sql);
										while (resultSet.next()) {
								%>
							
							<tbody>
								<tr>
									<td>
									<% 
									if(resultSet.getString("SELECTED_IN")!=null &&
										resultSet.getString("SELECTED_IN").toString()
										.contains(session.getAttribute("user").toString())){
									%>
										<%=resultSet.getString("NAME")%> <span style="color:#0f0;"><strong>(Selected)</strong></span></td>
									<%
									}else{
									%>
										<%=resultSet.getString("NAME")%></td>
									<%
									}
									%>
									<td><%=resultSet.getString("BRANCH")%></td>
									<td><%=resultSet.getString("ROLL_NO")%></td>
									<td><%=resultSet.getString("EMAIL_ID")%></td>

									<td><%=resultSet.getString("MOBILE_NO")%></td>
									<td><%=resultSet.getString("CGPA")%></td>
									<td><%=resultSet.getString("SSC_MARKS")%></td>
									<td><%=resultSet.getString("HSC_MARKS")%></td>
									<td><%=resultSet.getString("ACTIVE_BACKLOG")%></td>
									<td><%=resultSet.getString("GAP")%></td>									
									<td><%=resultSet.getString("ADDRESS")%></td>
									<%
										String fileName1 = null;
												String fileName = null;
												fileName = resultSet.getString("IMAGE");
												if (!fileName.equalsIgnoreCase("assets/img/find_user.png"))
													fileName = "/Download?file=" + fileName + "&type=image/jpeg";
												else
													fileName = null;

												fileName1 = resultSet.getString("resume");
												if (fileName1 != null)
													fileName1 = "/Download?file=" + fileName1 + "&type=application/pdf";
									%>
									<td><center>
											<%
												if (fileName != null) {
											%><i data-toggle="modal"
												data-target="#myModal" class="fa fa-file image_view"
												style="font-size: 150%; color: black;cursor: pointer;"
												data-rel="<%=fileName%>"
												data-name="<%=resultSet.getString("NAME")%>"> </i>
											<%
												}
											%>
										</center></td>
									<td><center>
											<%
												if (fileName1 != null) {
											%><a href="<%=fileName1%>"
												target="_blank"><i class="fa fa-download"
												style="font-size: 150%; color: red;"></i></a>
											<%
												}
											%>
										</center></td>



								</tr>
							</tbody>
							<%
								}
									//connection.close();
								} catch (Exception e) {
									log.error("Could not view students : {}", e);
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
		&nbsp; <a href="menuForCompany.jsp"
			class="btn btn-danger square-btn-adjust">Back To Home Page</a>
	</div>

	<!-- /. PAGE INNER  -->
	</div>
	<!-- /. PAGE WRAPPER  -->
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<center>
						<b><h4 class="modal-title" id="modal_name">Name</h4></b>
					</center>
				</div>
				<div class="modal-body">
					<center>
						<div id="area"></div>
					</center>
				</div>
				<div class="modal-footer">
					<span id="download_button"></span>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
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
